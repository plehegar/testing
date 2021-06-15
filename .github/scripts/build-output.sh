#!/bin/bash
set -ev

TMPDIR=deploybuild

rm -rf ${TMPDIR}
mkdir ${TMPDIR}

cp index.html ${TMPDIR}
