#!/bin/bash

if [ $FOLDER -eq "" ]
then
 echo "build-output needs a build directory name in FOLDER env variable"
 exit 1
fi

TMPDIR=$FOLDER


echo Cleaning $TMPDIR before building

rm -rf ${TMPDIR}
mkdir ${TMPDIR}

# Place your build operations below

echo Now building the output in the director ./$TMPDIR

cp index.html ${TMPDIR}
