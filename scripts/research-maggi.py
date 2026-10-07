exec(open(r'C:\Users\rauna\Desktop\Bots\Engineer\scripts\research-indian-snacks.py',encoding='utf-8').read().split('queries = [')[0])
queries=[('maggi-global','https://world.openfoodfacts.org/api/v2/search?'+urllib.parse.urlencode({'brands_tags':'maggi','page_size':30,'fields':fields,'lc':'en'})),
    ('maggi-known','https://world.openfoodfacts.org/api/v3/product/8901058000290.json?'+urllib.parse.urlencode({'fields':fields,'lc':'en'}))]
for name,url in queries:
    dest=OUT/(name+'.json')
    if dest.exists(): continue
    try:
        req=urllib.request.Request(url,headers={'User-Agent':'KaloResearch/1.0 (personal local barcode research; no writes)'})
        with urllib.request.urlopen(req,timeout=45) as response: data=json.load(response)
        dest.write_text(json.dumps({'retrieved_date':'2026-10-02','source_url':url,'response':data},ensure_ascii=False,indent=2),encoding='utf-8')
        print(name,'count',data.get('count'),'product',data.get('product',{}).get('product_name'))
    except Exception as exc: print(name,type(exc).__name__,str(exc))
    time.sleep(7)
