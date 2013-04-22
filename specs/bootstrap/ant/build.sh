#!/bin/bash

source ../../../bin/argeo-builder
argeo_builder_variables $PWD

VERSION=1.8.4

SOURCE_FILE=/ant/source/apache-ant-$VERSION-src.tar.gz
SOURCE_FILENAME=${SOURCE_FILE##*/}
SRC_DIR=$BUILD_DIR/src
CLASSES_DIR=$BUILD_DIR/classes

echo Download sources
argeo_builder_download_apache $SOURCE_FILE

echo Untar sources
reset_dir $BUILD_DIR
(cd $BUILD_DIR && tar -xzf $SOURCE_DIR/$SOURCE_FILENAME)
mv $BUILD_DIR/apache-ant-* $BUILD_DIR/apache-ant

echo Patch
(cd $BUILD_DIR/apache-ant && patch < $ARTIFACT_DIR/org.apache.ant-skipTestJars.patch)

echo Build bootstrap
(cd $BUILD_DIR/apache-ant && sh build.sh jars)

push_to_cache $BUILD_DIR/apache-ant/build/lib/ant.jar
push_to_cache $BUILD_DIR/apache-ant/build/lib/ant-launcher.jar
