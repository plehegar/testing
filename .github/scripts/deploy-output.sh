#!/bin/bash
set -ev
STATUS=`git log -1 --pretty=oneline`

rm -rf out
mkdir out

cd out

FULL_REPO="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git/"

TARGET_BRANCH="gh-pages"

git remote set-url origin "${FULL_REPO}"
git pull origin "${TARGET_BRANCH}" --rebase

ls -la

cd ..

ls -la

cp index.html out/testing

cd out/testing

ls -la

git push --force-with-lease origin "${TARGET_BRANCH}"

exit 0

git init
git config user.name "GitHub-Action"
git config user.email "github-action@users.noreply.github.com"
ls
git add .
git commit -m "Built by GitHub action: ${STATUS}"
git status


git push --force --quiet $FULL_REPO master:gh-pages
