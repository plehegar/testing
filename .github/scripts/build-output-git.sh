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
git config --global user.name $GITHUB_ACTOR
git config --global user.password $GITHUB_TOKEN

TMPDIR=$FOLDER


echo Cleaning $TMPDIR before building

MAIN=$PWD

rm -rf $TMPDIR
mkdir $TMPDIR

cd $TMPDIR

REPO_URL="https://$GITHUB_ACTOR:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git"

echo Using $GITHUB_REPOSITORY

git clone $REPO_URL

cd testing

git checkout gh-pages

TARGET=$PWD

# Place your build operations below

cd $MAIN

echo Now building the output in $TARGET

cp index.html ${TARGET}
cp redirect.html ${TARGET}

cd ${TARGET}

cat index.html

ls -la

echo "TRAVIS_BRANCH: ${TRAVIS_BRANCH}"
echo "TRAVIS_PULL_REQUEST: ${TRAVIS_PULL_REQUEST}"

if [ $TRAVIS_PULL_REQUEST = "" ]
then
  TRAVIS_PULL_REQUEST=false
fi

TRAVIS_BRANCH=${TRAVIS_BRANCH:-$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')}
TRAVIS_PULL_REQUEST=${TRAVIS_PULL_REQUEST:false}

echo "TRAVIS_BRANCH: ${TRAVIS_BRANCH}"
echo "TRAVIS_PULL_REQUEST: ${TRAVIS_PULL_REQUEST}"


exit 0


echo Diff

git diff

echo Add the changes

git add -A .

echo Commit the changes

git commit -m "Deploy to GitHub Pages: $GITHUB_SHA from branch \"$GITHUB_REF\""

echo Attempt to push

git push --force

echo done


