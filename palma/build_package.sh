#!/bin/bash

PACKAGE_DIR=enas

mkdir -p $PACKAGE_DIR

pip install tensorflow-gpu==1.14.0 numpy Pillow --target $PACKAGE_DIR

cp -r ../scripts $PACKAGE_DIR/scripts
cp -r ../src $PACKAGE_DIR/src
cp ../LICENSE $PACKAGE_DIR
cp ../README $PACKAGE_DIR
cp enas_job.sh $PACKAGE_DIR

tar cfvz enas_package.tar.gz $PACKAGE_DIR

rm -r $PACKAGE_DIR
