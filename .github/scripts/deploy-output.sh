#!/bin/bash
set -ev
STATUS=`git log -1 --pretty=oneline`

rm -rf out
mkdir out
cp index.html ./out/

cd out
git init
git config user.name "GitHub-Action"
git config user.email "github-action"
ls
git add .
git commit -m "Built by GitHub action: ${STATUS}"
git status

FULL_REPO="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git/"

git push --force --quiet $FULL_REPO master:gh-pages
