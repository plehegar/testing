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

TRAVIS_BRANCH=${GH_BRANCH:-$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')}
TRAVIS_PULL_REQUEST=${GH_EVENT_NUMBER:-false}

echo "TRAVIS_BRANCH: ${TRAVIS_BRANCH}"
echo "TRAVIS_PULL_REQUEST: ${TRAVIS_PULL_REQUEST}"

REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

echo "REPO: $REPO"
echo "SSH_REPO: $SSH_REPO"
echo "SHA: $SHA"
echo "GITHUB_SHA: $SHA"




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

git remote set-url origin $REPO_URL

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

if [ $TRAVIS_PULL_REQUEST != "false" ]
then
  exit 0
fi

if [[ -z $(git status --porcelain) ]]; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

echo Add the changes

git add -A .

echo Commit the changes

git commit -m "Deploy to GitHub Pages: $GITHUB_SHA from branch \"$GITHUB_REF\""

echo Attempt to push

git push --force $REPO_URL gh-pages

echo done


