import express from 'express';
import session from 'express-session';
import {SQLiteSessionStore} from './sqlite-session-store.js';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import bcrypt from 'bcryptjs';
import Database from 'better-sqlite3';
import multer from 'multer';
import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {quoteB2B,quoteB2C} from '../src/pricing.js';
const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'..');
const data=process.env.WEENY_DATA_DIR||process.env.DATA_DIR||path.join(root,'data');fs.mkdirSync(path.join(data,'uploads'),{recursive:true});
const db=new Database(path.join(data,'adaura.sqlite'));db.pragma('journal_mode=WAL');db.pragma('foreign_keys=ON');db.exec(fs.readFileSync(path.join(root,'server/schema.sql'),'utf8'));
const app=express();app.set('trust proxy',1);app.use(helmet({contentSecurityPolicy:false}));app.use(express.json({limit:'1mb'}));
let sessionSecret=process.env.SESSION_SECRET;
if(!sessionSecret){
 const secretFile=path.join(data,'.session-secret');
 try{
  sessionSecret=fs.readFileSync(secretFile,'utf8').trim();
 }catch(error){
  if(error.code!=='ENOENT')throw error;
  const generated=crypto.randomBytes(48).toString('hex');
  try{fs.writeFileSync(secretFile,generated,{flag:'wx',mode:0o600});sessionSecret=generated;}
  catch(writeError){if(writeError.code!=='EEXIST')throw writeError;sessionSecret=fs.readFileSync(secretFile,'utf8').trim();}
 }
}
if(sessionSecret.length<32)throw new Error('SESSION_SECRET must contain at least 32 characters.');
app.use(session({store:new SQLiteSessionStore(db),name:'adaura.sid',secret:sessionSecret,resave:false,saveUninitialized:false,cookie:{httpOnly:true,sameSite:'lax',secure:process.env.NODE_ENV==='production',maxAge:604800000}}));
app.use('/api/auth',rateLimit({windowMs:900000,limit:30}));
const upload=multer({dest:path.join(data,'uploads'),limits:{fileSize:25*1024*1024},fileFilter:(_r,f,cb)=>{const ok=['application/pdf','image/jpeg','image/png','image/webp','application/postscript','application/illustrator'].includes(f.mimetype);cb(ok?null:new Error('Unsupported file type'),ok)}});
const me=u=>u&&({id:u.id,name:u.name,email:u.email,phone:u.phone,customer_type:u.customer_type,business_name:u.business_name,gstin:u.gstin,account_status:u.account_status,role:u.role});
const user=req=>req.session.userId&&db.prepare('SELECT * FROM users WHERE id=?').get(req.session.userId);
const auth=(req,res,next)=>{req.user=user(req);if(!req.user)return res.status(401).json({error:'Please sign in.'});next()};
const admin=(req,res,next)=>req.user.role==='admin'?next():res.status(403).json({error:'Admin access required.'});
const approved=(req,res,next)=>req.user.role==='admin'||req.user.account_status==='approved'?next():res.status(403).json({error:'Your account is awaiting approval.'});
const settings=()=>db.prepare('SELECT * FROM pricing_settings WHERE id=1').get();
const price=(v,t,s)=>t==='b2b'?quoteB2B({supplierRateInclusive:v.supplier_rate_inclusive,markupPercent:s.b2b_markup_percent,minimumAddition:s.b2b_minimum_addition,gstRatePercent:v.gst_rate_percent}).unitPriceInclusive:quoteB2C({supplierRateInclusive:v.supplier_rate_inclusive,markupPercent:s.b2c_markup_percent,gstRatePercent:v.gst_rate_percent}).unitPriceInclusive;
const number=(prefix)=>prefix+'-'+Date.now().toString().slice(-8)+'-'+crypto.randomBytes(2).toString('hex').toUpperCase();
app.get('/api/health',(_q,r)=>r.json({ok:true,database:'SQLite'}));
app.post('/api/auth/register',async(q,r)=>{const b=q.body||{};if(!b.name||!b.email||!b.password||b.password.length<10)return r.status(400).json({error:'Name, email and password (10+ characters) required.'});if(!['b2b','b2c'].includes(b.customer_type||'b2c'))return r.status(400).json({error:'Invalid customer type.'});try{const h=await bcrypt.hash(b.password,12),x=db.prepare('INSERT INTO users(name,email,password_hash,phone,customer_type,business_name,gstin) VALUES(?,?,?,?,?,?,?)').run(b.name.trim(),b.email.trim().toLowerCase(),h,b.phone||null,b.customer_type||'b2c',b.business_name||null,b.gstin||null);q.session.regenerate(err=>{if(err)return r.status(500).json({error:'Could not start session.'});q.session.userId=x.lastInsertRowid;q.session.save(e=>e?r.status(500).json({error:'Could not save session.'}):r.status(201).json({user:me(user(q))}));});}catch(e){r.status(409).json({error:e.code==='SQLITE_CONSTRAINT_UNIQUE'?'Email already registered.':'Could not register.'});}});
app.post('/api/auth/login',async(q,r)=>{const u=db.prepare('SELECT * FROM users WHERE email=? COLLATE NOCASE').get(String(q.body?.email||'').trim());if(!u||!await bcrypt.compare(String(q.body?.password||''),u.password_hash))return r.status(401).json({error:'Email or password is incorrect.'});q.session.regenerate(err=>{if(err)return r.status(500).json({error:'Could not start session.'});q.session.userId=u.id;q.session.save(e=>e?r.status(500).json({error:'Could not save session.'}):r.json({user:me(u)}));});});
app.post('/api/auth/logout',(q,r)=>q.session.destroy(()=>r.json({ok:true})));
app.get('/api/auth/me',(q,r)=>r.json({user:me(user(q))||null}));
app.get('/api/catalogue',(q,r)=>{const u=user(q),s=settings(),products=db.prepare('SELECT * FROM products WHERE active=1 ORDER BY sort_order,name').all(),variants=db.prepare('SELECT * FROM variants WHERE active=1').all().map(v=>({id:v.id,product_id:v.product_id,sku:v.sku,name:v.name,options:JSON.parse(v.options_json),quantity_unit:v.quantity_unit,gst_rate_percent:v.gst_rate_percent,unit_price_inclusive:u?.account_status==='approved'?price(v,u.customer_type,s):null}));r.json({products,variants,customer_type:u?.customer_type||'guest'});});
app.post('/api/enquiries',auth,approved,(q,r)=>{const b=q.body||{};if(!Array.isArray(b.items)||!b.items.length||b.items.length>50)return r.status(400).json({error:'Add 1–50 items.'});let total=0;const snap=[];for(const item of b.items){const v=db.prepare('SELECT * FROM variants WHERE id=? AND active=1').get(Number(item.variant_id)),qty=Number(item.quantity);if(!v||!Number.isInteger(qty)||qty<1||qty>10000)return r.status(400).json({error:'Invalid item or quantity.'});const p=db.prepare('SELECT name FROM products WHERE id=?').get(v.product_id),unit=price(v,q.user.customer_type,settings()),line=Math.round(unit*qty*100)/100;total=Math.round((total+line)*100)/100;snap.push({product_name:p.name,variant_name:v.name,options:JSON.parse(v.options_json),quantity:qty,quantity_unit:v.quantity_unit,gst_rate_percent:v.gst_rate_percent,unit_price_inclusive:unit,line_total_inclusive:line});}const key=String(b.idempotency_key||crypto.randomUUID()).slice(0,100),old=db.prepare('SELECT id,enquiry_number,status,subtotal_inclusive FROM enquiries WHERE customer_id=? AND idempotency_key=?').get(q.user.id,key);if(old)return r.json({enquiry:old,replayed:true});const n=number('AE');try{const x=db.prepare('INSERT INTO enquiries(enquiry_number,customer_id,items_json,subtotal_inclusive,customer_notes,contact_phone,delivery_location,idempotency_key) VALUES(?,?,?,?,?,?,?,?)').run(n,q.user.id,JSON.stringify(snap),total,String(b.customer_notes||'').slice(0,3000),String(b.contact_phone||'').slice(0,30),String(b.delivery_location||'').slice(0,200),key);r.status(201).json({enquiry:{id:x.lastInsertRowid,enquiry_number:n,status:'new',subtotal_inclusive:total}});}catch{r.status(409).json({error:'Duplicate or invalid enquiry.'});}});
app.get('/api/my/enquiries',auth,(q,r)=>r.json({enquiries:db.prepare('SELECT id,enquiry_number,status,subtotal_inclusive,created_at FROM enquiries WHERE customer_id=? ORDER BY id DESC').all(q.user.id)}));
app.get('/api/my/orders',auth,(q,r)=>r.json({orders:db.prepare('SELECT * FROM orders WHERE customer_id=? ORDER BY id DESC').all(q.user.id)}));
app.post('/api/my/enquiries/:id/artwork',auth,approved,upload.single('artwork'),(q,r)=>{const e=db.prepare('SELECT id FROM enquiries WHERE id=? AND customer_id=?').get(q.params.id,q.user.id);if(!e){if(q.file)fs.unlinkSync(q.file.path);return r.sendStatus(404);}if(!q.file)return r.status(400).json({error:'Choose an artwork file to upload.'});const x=db.prepare('INSERT INTO artwork_files(enquiry_id,customer_id,stored_name,original_name,mime_type,size_bytes) VALUES(?,?,?,?,?,?)').run(e.id,q.user.id,q.file.filename,q.file.originalname,q.file.mimetype,q.file.size);r.status(201).json({id:x.lastInsertRowid,review_status:'pending'});});
app.get('/api/admin/summary',auth,admin,(_q,r)=>r.json({customers:db.prepare('SELECT count(*) n FROM users WHERE role=\'customer\'').get().n,pending:db.prepare('SELECT count(*) n FROM users WHERE account_status=\'pending\'').get().n,products:db.prepare('SELECT count(*) n FROM products').get().n,enquiries:db.prepare('SELECT count(*) n FROM enquiries').get().n,orders:db.prepare('SELECT count(*) n FROM orders').get().n}));
app.get('/api/admin/customers',auth,admin,(_q,r)=>r.json({customers:db.prepare('SELECT id,name,email,phone,customer_type,business_name,gstin,account_status FROM users WHERE role=\'customer\' ORDER BY id DESC').all()}));
app.patch('/api/admin/customers/:id',auth,admin,(q,r)=>{const s=q.body?.account_status;if(!['pending','approved','blocked'].includes(s))return r.status(400).json({error:'Invalid status.'});db.prepare('UPDATE users SET account_status=? WHERE id=?').run(s,q.params.id);r.json({ok:true});});
app.get('/api/admin/products',auth,admin,(_q,r)=>r.json({products:db.prepare('SELECT * FROM products ORDER BY id DESC').all(),variants:db.prepare('SELECT * FROM variants ORDER BY id DESC').all()}));
app.post('/api/admin/products',auth,admin,(q,r)=>{const b=q.body||{};if(!b.name||!b.category)return r.status(400).json({error:'Name and category required.'});const x=db.prepare('INSERT INTO products(name,sku,category,description) VALUES(?,?,?,?)').run(b.name,b.sku||null,b.category,b.description||'');r.status(201).json({id:x.lastInsertRowid});});
app.post('/api/admin/variants',auth,admin,(q,r)=>{const b=q.body||{};if(!b.product_id||!b.name||!Number.isFinite(Number(b.supplier_rate_inclusive))||Number(b.supplier_rate_inclusive)<0)return r.status(400).json({error:'Product, variant and supplier rate required.'});const x=db.prepare('INSERT INTO variants(product_id,name,sku,options_json,supplier_rate_inclusive,gst_rate_percent,quantity_unit) VALUES(?,?,?,?,?,?,?)').run(b.product_id,b.name,b.sku||null,JSON.stringify(b.options||{}),Number(b.supplier_rate_inclusive),Number(b.gst_rate_percent??18),b.quantity_unit||'pack');r.status(201).json({id:x.lastInsertRowid});});
app.get('/api/admin/pricing',auth,admin,(_q,r)=>r.json({settings:settings()}));
app.put('/api/admin/pricing',auth,admin,(q,r)=>{const b=q.body||{},keys=['b2b_markup_percent','b2b_minimum_addition','b2c_markup_percent'];if(keys.some(k=>!Number.isFinite(Number(b[k]))||Number(b[k])<0))return r.status(400).json({error:'Invalid pricing settings.'});db.prepare('UPDATE pricing_settings SET b2b_markup_percent=?,b2b_minimum_addition=?,b2c_markup_percent=? WHERE id=1').run(...keys.map(k=>Number(b[k])));r.json({ok:true});});
app.get('/api/admin/enquiries',auth,admin,(_q,r)=>r.json({enquiries:db.prepare('SELECT e.*,u.name customer_name,u.email customer_email FROM enquiries e JOIN users u ON u.id=e.customer_id ORDER BY e.id DESC').all().map(e=>({...e,items:JSON.parse(e.items_json)}))}));
app.patch('/api/admin/enquiries/:id',auth,admin,(q,r)=>{const s=q.body?.status;if(!['new','reviewing','quoted','accepted','rejected','converted','closed'].includes(s))return r.status(400).json({error:'Invalid status.'});db.prepare('UPDATE enquiries SET status=? WHERE id=?').run(s,q.params.id);r.json({ok:true});});
app.post('/api/admin/enquiries/:id/convert',auth,admin,(q,r)=>{const e=db.prepare('SELECT * FROM enquiries WHERE id=?').get(q.params.id);if(!e)return r.sendStatus(404);const n=number('AO'),x=db.prepare('INSERT INTO orders(order_number,enquiry_id,customer_id,total_inclusive) VALUES(?,?,?,?)').run(n,e.id,e.customer_id,e.subtotal_inclusive);db.prepare('UPDATE enquiries SET status=\'converted\' WHERE id=?').run(e.id);r.status(201).json({id:x.lastInsertRowid,order_number:n});});
app.get('/api/admin/orders',auth,admin,(_q,r)=>r.json({orders:db.prepare('SELECT o.*,u.name customer_name FROM orders o JOIN users u ON u.id=o.customer_id ORDER BY o.id DESC').all()}));
app.patch('/api/admin/orders/:id',auth,admin,(q,r)=>{const b=q.body||{};if(b.status!==undefined&&!['confirmed','in_progress','completed','cancelled'].includes(b.status))return r.status(400).json({error:'Invalid order status.'});if(b.payment_status!==undefined&&!['unpaid','partial','paid','refunded'].includes(b.payment_status))return r.status(400).json({error:'Invalid payment status.'});db.prepare('UPDATE orders SET status=COALESCE(?,status),payment_status=COALESCE(?,payment_status),notes=COALESCE(?,notes) WHERE id=?').run(b.status||null,b.payment_status||null,b.notes??null,q.params.id);r.json({ok:true});});
app.use('/uploads',auth,(q,r,next)=>{const f=db.prepare('SELECT customer_id FROM artwork_files WHERE stored_name=?').get(path.basename(q.path));if(!f||!(f.customer_id===q.user.id||q.user.role==='admin'))return r.sendStatus(404);next();},express.static(path.join(data,'uploads')));
app.use(express.static(path.join(root,'public'),{index:'index.html',dotfiles:'deny'}));
app.use((e,_q,r,_n)=>{console.error(e);r.status(400).json({error:e.message||'Request failed.'});});
if(process.env.ADMIN_EMAIL&&process.env.ADMIN_PASSWORD){
 const existing=db.prepare("SELECT id FROM users WHERE email=? COLLATE NOCASE").get(process.env.ADMIN_EMAIL);
 if(!existing){
  const hash=await bcrypt.hash(process.env.ADMIN_PASSWORD,12);
  db.prepare("INSERT INTO users(name,email,password_hash,role,account_status,customer_type) VALUES(?,?,?,'admin','approved','b2b')").run(process.env.ADMIN_NAME||'AdAura Administrator',process.env.ADMIN_EMAIL,hash);
  console.log('Initial administrator account created.');
 }
}
if(process.env.NODE_ENV==='production'&&(!process.env.SESSION_SECRET||process.env.SESSION_SECRET.length<32)){
 throw new Error('Set a SESSION_SECRET of at least 32 characters in production.');
}
const port=Number(process.env.PORT||3000);app.listen(port,()=>console.log('AdAura standalone server on '+port));
