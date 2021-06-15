#!/bin/bash
set -ev

if [ $# -eq 0 ]
then
 echo "build-output needs a build directory name as argument"
 exit 1
fi

TMPDIR=$1


echo Cleaning $TMPDIR before building

echo FOLDER is $FOLDER

rm -rf ${TMPDIR}
mkdir ${TMPDIR}

# Place your build operations below

echo Now building the output in the director ./$TMPDIR

cp index.html ${TMPDIR}
