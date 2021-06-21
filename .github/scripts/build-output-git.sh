#!/bin/bash
set -e

if [ $FOLDER = "" ]
then
 echo "build-output-git needs a build directory name in FOLDER env variable"
 exit 1
fi

if [ $GITHUB_TOKEN = "" ]
then
 echo "build-output-git needs the Github token in GITHUB_TOKEN env variable"
 exit 1
fi

git config --global user.email "github-action@users.noreply.github.com"
git config --global user.name "GitHub Action"
git config --global user.password ${GITHUB_TOKEN}

TMPDIR=$FOLDER


echo Cleaning $TMPDIR before building

MAIN=$PWD

rm -rf $TMPDIR
mkdir $TMPDIR

cd $TMPDIR

REPO_URL="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY"

echo Using $REPO_URL

git clone $REPO_URL.git

cd testing

git checkout gh-pages

TARGET=$PWD

# Place your build operations below

cd $MAIN

echo Now building the output in the director $MAIN

cp -u index.html ${MAIN}
cp -u redirect.html ${MAIN}

cd ${MAIN}

ls -la

git add -A .

git commit -m "Deploy to GitHub Pages: ${GITHUB_SHA} from branch \"${GITHUB_REF}\""

git push
