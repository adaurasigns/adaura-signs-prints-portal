import {test} from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import Database from 'better-sqlite3';

test('SQLite schema creates portal tables and pricing defaults', () => {
  const db = new Database(':memory:');
  db.exec(fs.readFileSync(new URL('./schema.sql', import.meta.url),'utf8'));
  const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table'").all().map(x=>x.name);
  for (const name of ['users','products','variants','pricing_settings','enquiries','orders','payments','artwork_files']) {
    assert.ok(tables.includes(name), 'missing table '+name);
  }
  assert.equal(db.prepare('SELECT b2b_markup_percent FROM pricing_settings WHERE id=1').get().b2b_markup_percent,20);
  assert.equal(db.prepare('SELECT b2c_markup_percent FROM pricing_settings WHERE id=1').get().b2c_markup_percent,100);
  db.close();
});
