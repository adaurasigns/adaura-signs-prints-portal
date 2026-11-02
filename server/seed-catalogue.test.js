import {test} from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {execFileSync} from 'node:child_process';
import Database from 'better-sqlite3';
import {fileURLToPath} from 'node:url';

const projectRoot=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'..');

test('catalogue import creates all supplier groups and variants under WEENY_DATA_DIR, without duplicating on restart',()=>{
  const dataDir=fs.mkdtempSync(path.join(os.tmpdir(),'adaura-weeny-test-'));
  try{
    const env={...process.env,WEENY_DATA_DIR:dataDir};
    const importer=path.join(projectRoot,'server','seed-catalogue.js');
    execFileSync(process.execPath,[importer],{env,stdio:'pipe'});
    let db=new Database(path.join(dataDir,'adaura.sqlite'));
    assert.equal(db.prepare("SELECT count(*) n FROM products WHERE sku LIKE 'VC-%'").get().n,17);
    assert.equal(db.prepare("SELECT count(*) n FROM variants WHERE sku LIKE 'VC-%'").get().n,118);
    const metal=db.prepare("SELECT supplier_rate_inclusive FROM variants WHERE sku='VC-METAL-001'").get();
    assert.equal(metal.supplier_rate_inclusive,3043);
    db.close();

    execFileSync(process.execPath,[importer],{env,stdio:'pipe'});
    db=new Database(path.join(dataDir,'adaura.sqlite'));
    assert.equal(db.prepare("SELECT count(*) n FROM products WHERE sku LIKE 'VC-%'").get().n,17);
    assert.equal(db.prepare("SELECT count(*) n FROM variants WHERE sku LIKE 'VC-%'").get().n,118);
    db.close();
  }finally{
    fs.rmSync(dataDir,{recursive:true,force:true});
  }
});
