from pathlib import Path
import json,math,re,datetime
ROOT=Path('docs/evidence/indian-snacks-2026-10-02')
merged={}
for file in sorted(ROOT.glob('*.json')):
 if file.name=='indian-snacks-100.json':continue
 d=json.loads(file.read_text(encoding='utf8'))
 if 'response' not in d:continue
 r=d['response']
 for p in r.get('products',[r.get('product',{})]):
  code=p.get('code','')
  if code and (code not in merged or len(p.get('images',{}))>len(merged[code][0].get('images',{}))):merged[code]=(p,file.name)
def valid_gtin(s):
 return s.isdigit() and len(s) in (8,12,13,14) and (10-sum(int(v)*(3 if i%2==0 else 1) for i,v in enumerate(s[-2::-1]))%10)%10==int(s[-1])
def number(n,k):
 v=n.get(k)
 return v if isinstance(v,(float,int)) and math.isfinite(v) else None
rows=[]
for code,(p,file) in merged.items():
 name=p.get('product_name') or p.get('product_name_en') or ''
 if not valid_gtin(code) or 'en:india' not in p.get('countries_tags',[]) or not name or re.search(r'bread|lassi|winking|winkin|cheese slices|frooti|appy fizz|flavored milk',name,re.I):continue
 if name.lower().strip() in ('britannia','parle'):continue
 roles=[k for k,v in p.get('images',{}).items() if k.startswith('nutrition_') and 'rev' in v and '400' in v.get('sizes',{})]
 if not roles:continue
 role='nutrition_en' if 'nutrition_en' in roles else sorted(roles)[0]; img=p['images'][role]
 padded=code.zfill(13); parts='/'.join([padded[:3],padded[3:6],padded[6:9],padded[9:]])
 label=f"https://images.openfoodfacts.org/images/products/{parts}/{role}.{img['rev']}.400.jpg"
 n=p.get('nutriments',{}); prepared=not any(k in n for k in ['energy-kcal_100g','fat_100g','carbohydrates_100g','proteins_100g']); suffix='_prepared_100g' if prepared else '_100g'
 nutrients={key:number(n,off+suffix) for key,off in [('kcal','energy-kcal'),('protein_g','proteins'),('carbohydrate_g','carbohydrates'),('fat_g','fat'),('sugar_g','sugars'),('salt_g','salt')]}
 if any(v is not None and (v<0 or v>(1000 if k=='kcal' else 100)) for k,v in nutrients.items()):continue
 lower=name.lower(); cat='sweets/candy' if 'rasgulla' in lower else ('cake/rusk/wafer' if 'rusky' in lower else ('noodles' if code=='8901058000290' else ('namkeen/chips' if file.startswith(('haldirams','bikaji')) or re.search('peanuts|chatkeens|full toss|cheeselings',lower) else ('sweets/candy' if re.search('poppins|melody|mango|rasgulla',lower) else ('cake/rusk/wafer' if re.search('cake|rusk|toastea|waff|croissant|choco rolls',lower) else 'biscuits/cookies')))))
 rows.append(dict(barcode=code,name=name,brand=p.get('brands'),pack_size_as_recorded=p.get('quantity') or None,category=cat,countries_as_recorded=p.get('countries_tags'),nutrition_per_100g_as_recorded=nutrients,nutrition_basis=('prepared: requires label review' if any('_prepared_100g' in k for k in n) else 'unknown: no usable nutrition values') if prepared else 'as sold: community database',automatic_nutrition_import_allowed=False,label_url=label,label_image_role=role,label_image_revision=img['rev'],label_status='metadata-derived link; not visually verified',front_image_url=p.get('image_front_url'),source_url=f'https://world.openfoodfacts.org/product/{code}',raw_source_file=file,source_quality_tags=p.get('data_quality_tags',[]),source_last_modified_utc=datetime.datetime.fromtimestamp(p['last_modified_t'],datetime.timezone.utc).isoformat() if p.get('last_modified_t') else None))
rows.sort(key=lambda r:(0 if r['barcode']=='8901058000290' else 1, {'namkeen/chips':0,'biscuits/cookies':1,'cake/rusk/wafer':2,'sweets/candy':3,'noodles':4}[r['category']],r['name'].lower(),r['barcode']))
assert len(rows)>=100,len(rows)
rows=rows[:100]
assert len({r['barcode'] for r in rows})==100
meta=dict(title='100 Indian-market snack and pack variants',retrieved_date='2026-10-02',state='Draft',selection='Curated from India-tagged Maggi, Haldiram, Bikaji, Britannia and Parle records with valid GTIN check digits and nutrition-image metadata. Not a sales ranking. Pack variants count separately.',source='Open Food Facts contributors',database_license='ODbL; individual contents DBCL; photos CC BY-SA with possible third-party rights',limitations=['Community records are not manufacturer verified.','Image links have not been fetched or visually verified.','Quantity and nutrition copied as recorded; missing fields remain null.','All records require pack and label review before automatic app import.','Prepared nutrition is kept distinct from as-sold nutrition.','Existing raw snapshots preserve source metadata and quality flags.'],products=rows)
(ROOT/'indian-snacks-100.json').write_text(json.dumps(meta,ensure_ascii=False,indent=2),encoding='utf8')
md=['# 100 Indian-market snack and pack variants','', 'Retrieved 2026-10-02. Draft research catalog; not a sales ranking. Different pack barcodes count separately. All 100 have GTIN check digits that pass and nutrition-photo metadata. These checks do not authenticate a barcode or verify a label.','', 'Source: [Open Food Facts](https://world.openfoodfacts.org/). Community data needs comparison with the actual packet before importing nutrition into the app. Photo links are built from source image metadata and have not been visually checked. Unknown pack sizes remain unknown. Maggi has prepared-nutrition metadata and needs particular review.','', 'Database: ODbL; individual contents: DBCL; photos: CC BY-SA, with possible third-party rights. [API and license documentation](https://openfoodfacts.github.io/documentation/docs/Product-Opener/api/). [Image URL documentation](https://openfoodfacts.github.io/documentation/docs/Product-Opener/api/how-to-download-images/).','', '| # | Product | Barcode | Pack as recorded | Label | Source |','| --- | --- | --- | --- | --- | --- |']
for i,r in enumerate(rows,1):
 esc=lambda x:str(x or 'Unknown').replace('|','/').replace('\n',' ')
 md.append(f"| {i} | {esc(r['name'])} | {r['barcode']} | {esc(r['pack_size_as_recorded'])} | [Photo]({r['label_url']}) | [Record]({r['source_url']}) |")
(ROOT/'INDIAN_SNACKS_100.md').write_text('\n'.join(md)+'\n',encoding='utf8')
print('eligible',len(merged),'selected',len(rows),'categories',{c:sum(r['category']==c for r in rows) for c in set(r['category'] for r in rows)})
print('missing kcal',sum(r['nutrition_per_100g_as_recorded']['kcal'] is None for r in rows))
