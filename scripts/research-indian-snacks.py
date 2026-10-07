from pathlib import Path
import json, urllib.request, urllib.parse, time

OUT = Path(r'C:\Users\rauna\Desktop\Bots\Engineer\docs\evidence\indian-snacks-2026-10-02')
OUT.mkdir(parents=True, exist_ok=True)
fields='code,product_name,product_name_en,brands,quantity,categories_tags,countries_tags,nutrition_data_per,nutriments,image_front_url,image_nutrition_url,selected_images,images,url,last_modified_t,data_quality_tags,popularity_key'
queries = [
    ('maggi-small', {'countries_tags_en':'india','brands_tags':'maggi','page_size':15}),
    ('britannia-page2', {'countries_tags_en':'india','brands_tags':'britannia','page_size':50,'page':2}),
    ('parle-page2', {'countries_tags_en':'india','brands_tags':'parle','page_size':50,'page':2}),
    ('haldirams-page2', {'countries_tags_en':'india','brands_tags':'haldiram-s','page_size':40,'page':2}),
]
for name, params in queries:
    dest=OUT/(name+'.json')
    if dest.exists():
        print(name, 'cached')
        continue
    params['fields']=fields
    params['lc']='en'
    url='https://world.openfoodfacts.org/api/v2/search?'+urllib.parse.urlencode(params)
    request=urllib.request.Request(url, headers={'User-Agent':'KaloResearch/1.0 (personal local barcode research; no writes)','Accept':'application/json'})
    try:
        with urllib.request.urlopen(request,timeout=60) as response:
            data=json.load(response)
        dest.write_text(json.dumps({'retrieved_date':'2026-10-02','source_url':url,'response':data},ensure_ascii=False,indent=2),encoding='utf-8')
        products=data.get('products',[])
        print(name, 'total',data.get('count'), 'returned',len(products),'nutrition_images',sum(bool(p.get('image_nutrition_url')) for p in products))
        print([(p.get('code'),p.get('product_name'),bool(p.get('image_nutrition_url'))) for p in products[:5]])
    except Exception as exc:
        print(name,type(exc).__name__,str(exc))
    time.sleep(7)
