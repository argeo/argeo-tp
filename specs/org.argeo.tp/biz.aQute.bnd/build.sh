#!/bin/bash

source ../../../bin/argeo-builder
argeo_builder_variables $PWD

VERSION=2.0.0

echo Checkout
[ -d $SOURCE_DIR ] && echo git pull || mkdir -p $SOURCE_DIR; (cd $SOURCE_DIR && git clone git://github.com/bndtools/bnd.git .);
#mkdir -p $SOURCE_DIR


echo Build
reset_dir $BUILD_DIR
(cd $BUILD_DIR && git clone file://$SOURCE_DIR .)
(cd $BUILD_DIR && run_ant dist)

push_to_cache $BUILD_DIR/dist/bundles/biz.aQute.bnd/biz.aQute.bnd-$VERSION.jar
push_to_cache $BUILD_DIR/dist/bundles/biz.aQute.bndlib/biz.aQute.bndlib-$VERSION.jar

