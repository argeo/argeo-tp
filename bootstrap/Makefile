-include sdk.mk

ECJ_VERSION=4.26

BND_VERSION=5.3.0
OSGI_CORE_VERSION=7.0.0
OSGI_CMPN_VERSION=7.0.0
OSGI_ANNOTATION_VERSION=7.0.0
SLF4J_VERSION=1.7.36

ORIGIN_BASE=$(HOME)/.cache/argeo/build/origin
SDK_BUILD_BASE ?= ./output
BOOTSTRAP_BASE=$(SDK_BUILD_BASE)/bootstrap

ECJ_BASE=./ecj
ECJ_SRC=$(ECJ_BASE)/OSGI-OPT/src

BNDLIB_BASE=./bndlib
BNDLIB_SRC=$(BNDLIB_BASE)/OSGI-OPT/src

OSGI_BASE=$(BOOTSTRAP_BASE)/osgi

SOURCE_ARCHIVES=\
$(ORIGIN_BASE)/ecjsrc-$(ECJ_VERSION).jar \
$(ORIGIN_BASE)/org.osgi/osgi.core-$(OSGI_CORE_VERSION)-sources.jar \
$(ORIGIN_BASE)/org.osgi/osgi.cmpn-$(OSGI_CMPN_VERSION)-sources.jar \
$(ORIGIN_BASE)/org.osgi/osgi.annotation-$(OSGI_ANNOTATION_VERSION)-sources.jar \
$(ORIGIN_BASE)/org.slf4j/slf4j-api-$(SLF4J_VERSION)-sources.jar \
$(ORIGIN_BASE)/bnd-$(BND_VERSION).tar.gz

all: ecj-build bndlib-build	
	make -C org.argeo.tp.build all

ecj-build:
	mkdir -p $(BOOTSTRAP_BASE)
	# list sources
	find $(ECJ_BASE)/OSGI-OPT/src | grep "\.java" > $(BOOTSTRAP_BASE)/ecj.todo
	# build
	$(JAVA_HOME)/bin/javac -d $(ECJ_BASE) -source 17 -target 17 -Xlint:none @$(BOOTSTRAP_BASE)/ecj.todo
	
bndlib-build: ecj-build
	$(JAVA_HOME)/bin/java -cp $(ECJ_BASE) org.eclipse.jdt.internal.compiler.batch.Main -nowarn \
		-source 17 -target 17 \
		$(BNDLIB_SRC) \
		-d $(BNDLIB_BASE)

clean:
	$(RM) -rf $(BOOTSTRAP_BASE)
	find $(ECJ_BASE) -name "*.class" -type f -exec rm -f {} \;
	find $(BNDLIB_BASE) -name "*.class" -type f -exec rm -f {} \;
	make -C org.argeo.tp.build clean

distclean:
	$(RM) -f sdk.mk
	$(RM) -rf ./output

clean-sources:
	$(RM) -rf $(ECJ_BASE)
	$(RM) -rf $(BNDLIB_BASE)
	$(RM) -rf org.argeo.tp.build/biz.aQute.bndlib/src
	$(RM) -rf org.argeo.tp.build/org.eclipse.jdt.core.compiler.batch/src
	
deb-source: distclean clean-sources bootstrap-prepare-sources
	debuild --no-sign -S
	$(RM) -f debian/files
	$(RM) -rf $(ECJ_BASE)
	$(RM) -rf $(BNDLIB_BASE)
	$(RM) -rf org.argeo.tp.build/biz.aQute.bndlib/src

bootstrap-prepare-sources: bootstrap-download-sources
	## ECJ
	mkdir -p $(ECJ_BASE)
	cd $(ECJ_BASE) && jar -xf $(ORIGIN_BASE)/ecjsrc-$(ECJ_VERSION).jar
	# remove ant-dependent class
	$(RM) $(ECJ_BASE)/org/eclipse/jdt/core/JDTCompilerAdapter.java
	# clean up
	$(RM) $(ECJ_BASE)/*.jar
	$(RM) $(ECJ_BASE)/build.xml
	$(RM) $(ECJ_BASE)/ecj.1
	$(RM) -rf $(ECJ_BASE)/scripts
	# TODO: keep the service files
	$(RM) -rf  $(ECJ_BASE)/META-INF

	# copy sources and resources
	mkdir -p $(ECJ_SRC)
	cp -r $(ECJ_BASE)/org $(ECJ_SRC)
	# remove java sources
	cd $(ECJ_BASE) && find org -name "*.java" -type f -exec rm -f {} \;
	cd $(ECJ_BASE) && find org -name "*.html" -type f -exec rm -f {} \;
	
	## BNDLIB
	# copy sources
	mkdir -p $(BOOTSTRAP_BASE)
	cd $(BOOTSTRAP_BASE) && tar -xzf $(ORIGIN_BASE)/bnd-$(BND_VERSION).tar.gz
	mkdir -p $(BNDLIB_SRC)
	cp -r $(BOOTSTRAP_BASE)/bnd-$(BND_VERSION).REL/aQute.libg/src/* $(BNDLIB_SRC)
	cp -r $(BOOTSTRAP_BASE)/bnd-$(BND_VERSION).REL/biz.aQute.bndlib/src/* $(BNDLIB_SRC)
	cp -r $(BOOTSTRAP_BASE)/bnd-$(BND_VERSION).REL/biz.aQute.bnd.annotation/src/* $(BNDLIB_SRC)	
	$(RM) -rf $(BOOTSTRAP_BASE)/bnd-$(BND_VERSION).REL

	# OSGi
	mkdir -p $(OSGI_BASE)
	cd $(OSGI_BASE) && jar -xf $(ORIGIN_BASE)/org.osgi/osgi.core-$(OSGI_CORE_VERSION)-sources.jar
	cd $(OSGI_BASE) && jar -xf $(ORIGIN_BASE)/org.osgi/osgi.cmpn-$(OSGI_CMPN_VERSION)-sources.jar
	cd $(OSGI_BASE) && jar -xf $(ORIGIN_BASE)/org.osgi/osgi.annotation-$(OSGI_ANNOTATION_VERSION)-sources.jar
	
	mkdir -p $(BNDLIB_SRC)/org/osgi/service
	cp -r $(OSGI_BASE)/org/osgi/annotation $(BNDLIB_SRC)/org/osgi
	cp -r $(OSGI_BASE)/org/osgi/resource $(BNDLIB_SRC)/org/osgi
	cp -r $(OSGI_BASE)/org/osgi/framework $(BNDLIB_SRC)/org/osgi
	cp -r $(OSGI_BASE)/org/osgi/namespace $(BNDLIB_SRC)/org/osgi
	cp -r $(OSGI_BASE)/org/osgi/util $(BNDLIB_SRC)/org/osgi
	cp -r $(OSGI_BASE)/org/osgi/dto $(BNDLIB_SRC)/org/osgi
	cp -r $(OSGI_BASE)/org/osgi/service/repository $(BNDLIB_SRC)/org/osgi/service
	cp -r $(OSGI_BASE)/org/osgi/service/log $(BNDLIB_SRC)/org/osgi/service

	# SLF4J
	cd $(BNDLIB_SRC) && jar -xf $(ORIGIN_BASE)/org.slf4j/slf4j-api-$(SLF4J_VERSION)-sources.jar
	$(RM) -rf $(BNDLIB_SRC)/META-INF
	cp -rv ../rebuild/org.argeo.tp/org.argeo.ext.slf4j/src/* $(BNDLIB_SRC)

	# clean up BNDLIB
	$(RM) -rf $(BNDLIB_SRC)/aQute/bnd/annotation/spi
	$(RM) -rf $(BNDLIB_SRC)/aQute/bnd/junit

	#mkdir -p org.argeo.tp.build/biz.aQute.bndlib/src
	#cp -r ../rebuild/org.argeo.tp/org.argeo.ext.slf4j/src/* org.argeo.tp.build/biz.aQute.bndlib/src
	
	# make sure directory is clean
	$(RM) -rf ./output

bootstrap-download-sources: $(SOURCE_ARCHIVES)

$(ORIGIN_BASE)/ecjsrc-$(ECJ_VERSION).jar:
	mkdir -p $(ORIGIN_BASE)
	wget -c -O $(ORIGIN_BASE)/ecjsrc-$(ECJ_VERSION).jar https://ftp-stud.hs-esslingen.de/Mirrors/eclipse/eclipse/downloads/drops4/R-4.26-202211231800/ecjsrc-$(ECJ_VERSION).jar
	
$(ORIGIN_BASE)/bnd-$(BND_VERSION).tar.gz:
	mkdir -p $(ORIGIN_BASE)
	wget -c -O $(ORIGIN_BASE)/bnd-$(BND_VERSION).tar.gz https://github.com/bndtools/bnd/archive/refs/tags/$(BND_VERSION).REL.tar.gz

$(ORIGIN_BASE)/org.osgi/osgi.core-$(OSGI_CORE_VERSION)-sources.jar:
	mkdir -p $(ORIGIN_BASE)/org.osgi
	wget -c -O $(ORIGIN_BASE)/org.osgi/osgi.core-$(OSGI_CORE_VERSION)-sources.jar https://repo1.maven.org/maven2/org/osgi/osgi.core/$(OSGI_CORE_VERSION)/osgi.core-$(OSGI_CORE_VERSION)-sources.jar

$(ORIGIN_BASE)/org.osgi/osgi.cmpn-$(OSGI_CMPN_VERSION)-sources.jar:
	mkdir -p $(ORIGIN_BASE)/org.osgi
	wget -c -O $(ORIGIN_BASE)/org.osgi/osgi.cmpn-$(OSGI_CMPN_VERSION)-sources.jar https://repo1.maven.org/maven2/org/osgi/osgi.cmpn/$(OSGI_CMPN_VERSION)/osgi.cmpn-$(OSGI_CMPN_VERSION)-sources.jar

$(ORIGIN_BASE)/org.osgi/osgi.annotation-$(OSGI_ANNOTATION_VERSION)-sources.jar:
	mkdir -p $(ORIGIN_BASE)/org.osgi
	wget -c -O $(ORIGIN_BASE)/org.osgi/osgi.annotation-$(OSGI_ANNOTATION_VERSION)-sources.jar https://repo1.maven.org/maven2/org/osgi/osgi.annotation/$(OSGI_ANNOTATION_VERSION)/osgi.annotation-$(OSGI_ANNOTATION_VERSION)-sources.jar

$(ORIGIN_BASE)/org.slf4j/slf4j-api-$(SLF4J_VERSION)-sources.jar:
	mkdir -p $(ORIGIN_BASE)/org.slf4j
	wget -c -O $(ORIGIN_BASE)/org.slf4j/slf4j-api-$(SLF4J_VERSION)-sources.jar https://repo1.maven.org/maven2/org/slf4j/slf4j-api/$(SLF4J_VERSION)/slf4j-api-$(SLF4J_VERSION)-sources.jar


	
