#!/bin/bash

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

rm -rf $TMPDIR
mkdir $TMPDIR

cd $TMPDIR

REPO_URL="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY"

git clone '$REPO_URL.git'

git checkout gh-pages

echo $PWD

ls -la

exit 0

# Place your build operations below

echo Now building the output in the director ./$TMPDIR

cp index.html ${TMPDIR}
cp redirect.html ${TMPDIR}

cd ${TMPDIR}

const repoURI = `https://x-access-token:${token}@github.com/${}.git/`

git remote set-url origin "${repoURI}"


git add -A .
git commit -m "Deploy to GitHub Pages: ${GITHUB_SHA} from branch \"${GITHUB_REF}\""

SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}

git push
