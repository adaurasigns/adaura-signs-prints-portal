import session from 'express-session';

export class SQLiteSessionStore extends session.Store {
  constructor(db) {
    super();
    this.db = db;
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS app_sessions (
        sid TEXT PRIMARY KEY,
        sess TEXT NOT NULL,
        expires INTEGER NOT NULL
      );
      CREATE INDEX IF NOT EXISTS idx_app_sessions_expires ON app_sessions(expires);
    `);
    this.db.prepare('DELETE FROM app_sessions WHERE expires <= ?').run(Date.now());
    this.getStmt = this.db.prepare('SELECT sess, expires FROM app_sessions WHERE sid = ?');
    this.setStmt = this.db.prepare(`
      INSERT INTO app_sessions (sid, sess, expires) VALUES (?, ?, ?)
      ON CONFLICT(sid) DO UPDATE SET sess = excluded.sess, expires = excluded.expires
    `);
    this.destroyStmt = this.db.prepare('DELETE FROM app_sessions WHERE sid = ?');
    this.touchStmt = this.db.prepare('UPDATE app_sessions SET expires = ? WHERE sid = ?');
  }

  get(sid, callback) {
    try {
      const row = this.getStmt.get(sid);
      if (!row) return callback(null, null);
      if (row.expires <= Date.now()) {
        this.destroyStmt.run(sid);
        return callback(null, null);
      }
      return callback(null, JSON.parse(row.sess));
    } catch (error) {
      return callback(error);
    }
  }

  set(sid, sess, callback) {
    try {
      const expires = sess.cookie?.expires
        ? new Date(sess.cookie.expires).getTime()
        : Date.now() + (Number(sess.cookie?.maxAge) || 86400000);
      this.setStmt.run(sid, JSON.stringify(sess), expires);
      callback?.(null);
    } catch (error) {
      callback?.(error);
    }
  }

  destroy(sid, callback) {
    try {
      this.destroyStmt.run(sid);
      callback?.(null);
    } catch (error) {
      callback?.(error);
    }
  }

  touch(sid, sess, callback) {
    try {
      const expires = sess.cookie?.expires
        ? new Date(sess.cookie.expires).getTime()
        : Date.now() + (Number(sess.cookie?.maxAge) || 86400000);
      this.touchStmt.run(expires, sid);
      callback?.(null);
    } catch (error) {
      callback?.(error);
    }
  }
}
