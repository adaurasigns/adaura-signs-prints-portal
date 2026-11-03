import {test} from 'node:test';
import assert from 'node:assert/strict';
import Database from 'better-sqlite3';
import {SQLiteSessionStore} from './sqlite-session-store.js';

test('SQLite session store persists, refreshes and destroys sessions', async () => {
  const db = new Database(':memory:');
  const store = new SQLiteSessionStore(db);
  const session = {cookie:{maxAge:60000,expires:new Date(Date.now()+60000)},userId:42};
  await new Promise((resolve,reject)=>store.set('sid-1',session,error=>error?reject(error):resolve()));
  const restored = await new Promise((resolve,reject)=>store.get('sid-1',(error,value)=>error?reject(error):resolve(value)));
  assert.equal(restored.userId,42);
  await new Promise((resolve,reject)=>store.touch('sid-1',session,error=>error?reject(error):resolve()));
  await new Promise((resolve,reject)=>store.destroy('sid-1',error=>error?reject(error):resolve()));
  const missing = await new Promise((resolve,reject)=>store.get('sid-1',(error,value)=>error?reject(error):resolve(value)));
  assert.equal(missing,null);
  db.close();
});

test('SQLite session store ignores expired sessions', async () => {
  const db = new Database(':memory:');
  const store = new SQLiteSessionStore(db);
  await new Promise((resolve,reject)=>store.set('expired',{cookie:{expires:new Date(Date.now()-1000)}},error=>error?reject(error):resolve()));
  const result = await new Promise((resolve,reject)=>store.get('expired',(error,value)=>error?reject(error):resolve(value)));
  assert.equal(result,null);
  db.close();
});
