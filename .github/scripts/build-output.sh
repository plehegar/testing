#!/bin/bash
set -ev

if [ $# -eq 0 ]
then
 echo "build-output needs a build directory name as argument"
 exit 1
fi

TMPDIR=$1

rm -rf ${TMPDIR}
mkdir ${TMPDIR}

# Place your build operations below

cp index.html ${TMPDIR}
