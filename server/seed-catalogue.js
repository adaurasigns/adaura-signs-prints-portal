import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import Database from 'better-sqlite3';

const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'..');
const data=process.env.DATA_DIR||path.join(root,'data');
fs.mkdirSync(data,{recursive:true});
const db=new Database(path.join(data,'adaura.sqlite'));
db.pragma('journal_mode=WAL');
db.pragma('foreign_keys=ON');
db.exec(fs.readFileSync(path.join(root,'server/schema.sql'),'utf8'));
const seed=JSON.parse(fs.readFileSync(path.join(root,'server/catalogue.seed.json'),'utf8'));
const insert= db.transaction(()=>{
  const product=db.prepare(`
    INSERT INTO products(sku,name,category,description,active,sort_order)
    VALUES(@sku,@name,@category,@description,1,@sort_order)
    ON CONFLICT(sku) DO UPDATE SET name=excluded.name,category=excluded.category,
      description=excluded.description,active=1,sort_order=excluded.sort_order
  `);
  for(const item of seed.products) product.run(item);
  const findProduct=db.prepare('SELECT id FROM products WHERE sku=?');
  const variant=db.prepare(`
    INSERT INTO variants(product_id,sku,name,options_json,supplier_rate_inclusive,gst_rate_percent,quantity_unit,active)
    VALUES(@product_id,@sku,@name,@options_json,@supplier_rate_inclusive,@gst_rate_percent,@quantity_unit,1)
    ON CONFLICT(sku) DO UPDATE SET product_id=excluded.product_id,name=excluded.name,
      options_json=excluded.options_json,supplier_rate_inclusive=excluded.supplier_rate_inclusive,
      gst_rate_percent=excluded.gst_rate_percent,quantity_unit=excluded.quantity_unit,active=1
  `);
  for(const item of seed.variants){
    const parent=findProduct.get(item.product_sku);
    if(!parent) throw new Error('Missing product for variant '+item.sku);
    variant.run({...item,product_id:parent.id,options_json:JSON.stringify(item.options)});
  }
});
insert();
const counts={
  products:db.prepare('SELECT count(*) n FROM products WHERE sku IS NOT NULL').get().n,
  variants:db.prepare('SELECT count(*) n FROM variants WHERE sku IS NOT NULL').get().n
};
console.log('Catalogue import complete:',JSON.stringify(counts));
db.close();
if(counts.products!==seed.products.length||counts.variants!==seed.variants.length)process.exitCode=1;
