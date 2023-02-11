#!/usr/bin/zsh
set -e
rm -rf src/dist
npm run build
cd src/dist
cp index.html 404.html
git init
git add .
git commit -m "deploy"
git remote add origin git@oldventura.github.com:oldventura/deprem.git
git push --force origin main:gh-pages
cd ../..
