import os, requests

TOKEN = os.getenv("REVERB_TOKEN")
BASE = "https://sandbox.reverb.com/api/listings"
HEADERS = {
    "Authorization": f"Bearer {TOKEN}",
    "Accept": "application/hal+json",
    "Accept-Version": "3.0",
    "Content-Type": "application/hal+json",
}

def page(url):
    return requests.get(url, headers=HEADERS, timeout=30)

q = "Gibson Flying V"
url = f"{BASE}?query={requests.utils.quote(q)}"
results = []

while url:
    r = page(url); r.raise_for_status()
    data = r.json()
    for it in data.get("listings", []):
        results.append({
            "id": it.get("id"),
            "title": it.get("title"),
            "make": it.get("make"),
            "model": it.get("model"),
            "finish": it.get("finish"),
            "year": it.get("year"),
            "condition": it.get("condition"),
            "price": (it.get("price") or {}).get("amount"),
            "currency": (it.get("price") or {}).get("currency"),
            "url": (((it.get("_links") or {}).get("web") or {}).get("href")),
        })
    nxt = (((data.get("_links") or {}).get("next") or {}).get("href"))
    url = f"https://sandbox.reverb.com{nxt}" if nxt and nxt.startswith("/") else nxt

# print a neat table
from textwrap import shorten
print(f"{'YEAR':<6} {'PRICE':>10}  TITLE")
for r in results:
    year = r["year"] or ""
    price = (f'{r["price"]} {r["currency"]}' if r["price"] else "")
    title = shorten(r["title"] or "", width=80)
    print(f"{str(year):<6} {price:>10}  {title}")
print("\nFirst 5 URLs:")
for r in results[:5]:
    print(r["url"])
