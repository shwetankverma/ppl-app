# How to deploy updates

## Every time you redeploy

Run this from the `ppl-app` folder before uploading:

```bash
./deploy.sh
```

That's it. It stamps a fresh timestamp into `sw.js`, which tells every browser that a new version exists. Users get the update on their next page load — no cache clearing, no hard refresh, nothing manual on their end.

## Why this works

The browser compares the service worker file byte-for-byte on every load. The moment `sw.js` changes (even one character), the browser installs the new version, deletes the old cache, and loads your latest files. The timestamp makes sure `sw.js` is always different after a deploy.

## If you use GitHub Pages

Add this to `.github/workflows/deploy.yml` to automate it:

```yaml
- name: Stamp SW version
  run: sed -i "s/__TIMESTAMP__/$(date +%Y%m%d%H%M%S)/" ppl-app/sw.js
```

## If you use Netlify

Add a `netlify.toml` at the root:

```toml
[build]
  command = "sed -i 's/__TIMESTAMP__/'\"$(date +%Y%m%d%H%M%S)\"'/' sw.js"
  publish = "."
```
