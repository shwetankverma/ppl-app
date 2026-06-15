#!/bin/bash
# Run this once before every deploy: ./deploy.sh
# It stamps the current timestamp into sw.js so the browser
# detects a new service worker and picks up your changes automatically.

TIMESTAMP=$(date +%Y%m%d%H%M%S)
sed -i.bak "s/__TIMESTAMP__/$TIMESTAMP/" sw.js
rm -f sw.js.bak
echo "✓ sw.js stamped with version: ppl-split-$TIMESTAMP"
echo ""
echo "Now push/upload your files as usual."
echo "Users will get the update on their next page load — no manual cache clearing needed."
