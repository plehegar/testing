#!/bin/sh

echo -- This is a script
echo -- The directory is $PATH
echo ----
echo -- GitHub version
git --version

echo "Directory Content $PWD"
ls -la

cd foobar

echo "Directory Content $PWD"
ls -la

