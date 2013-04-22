#!/bin/bash

source ../../../bin/argeo-builder
argeo_builder_variables $PWD

SOURCE_FILE=/eclipse/downloads/drops4/R-4.2.1-201209141800/ecjsrc-4.2.1.jar
SOURCE_FILENAME=${SOURCE_FILE##*/}
SRC_DIR=$BUILD_DIR/src
CLASSES_DIR=$BUILD_DIR/classes

BUNDLE_VERSION=3.8.2

# TODO make javac choice more configurable 
JAVAC=$JAVA_HOME/bin/javac
JAR=$JAVA_HOME/bin/jar

JAVAC_OPTS="-nowarn -source 1.6 -target 1.6 -classpath $CACHE_BASE/bootstrap/ant.jar"

echo Download sources
argeo_builder_download_eclipse $SOURCE_FILE

echo Unjar sources
reset_dir $SRC_DIR
(cd $SRC_DIR && $JAR -xvf $SOURCE_DIR/$SOURCE_FILENAME)

echo Compile
reset_dir $CLASSES_DIR
$JAVAC $JAVAC_OPTS -d $CLASSES_DIR $(find $SRC_DIR/org/* | grep .java) 2>&1 | tee $BUILD_DIR/build.log

echo Copy additional files
(cd $SRC_DIR && cp --parents $(find . | grep .rsc) $CLASSES_DIR)
(cd $SRC_DIR && cp --parents $(find . | grep .properties) $CLASSES_DIR)
(cd $SRC_DIR && cp --parents $(find . | grep .props) $CLASSES_DIR)
mkdir $CLASSES_DIR/META-INF
cp -r $SRC_DIR/META-INF/services $CLASSES_DIR/META-INF

echo Generate MANIFEST.MF
MANIFEST_FILE=$ARTIFACT_DIR/MANIFEST.MF

CACHE_JAR_FILE=${ARTIFACT_DIR/specs/cache}_$BUNDLE_VERSION.jar
echo Create jar file $CACHE_JAR_FILE
mkdir -p $(dirname $CACHE_JAR_FILE)
$JAR -cfm $CACHE_JAR_FILE $MANIFEST_FILE -C $CLASSES_DIR .
