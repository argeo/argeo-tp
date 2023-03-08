include ../sdk.mk
include ../common.mk

ECJ_VERSION=4.26
BND_VERSION=5.3.0

ORIGIN_BASE=$(HOME)/.cache/argeo/build/origin
BOOTSTRAP_BASE=$(SDK_BUILD_BASE)/bootstrap

ECJ_BASE=$(BOOTSTRAP_BASE)/ecj
ECJ_SRC=$(ECJ_BASE)/OSGI-OPT/src

BNDLIB_BASE=$(BOOTSTRAP_BASE)/bndlib
BNDLIB_SRC=$(BNDLIB_BASE)/OSGI-OPT/src

bootstrap-download-sources: $(ORIGIN_BASE)/ecjsrc-$(ECJ_VERSION).jar $(ORIGIN_BASE)/bnd-$(BND_VERSION).tar.gz
	
$(ORIGIN_BASE)/ecjsrc-$(ECJ_VERSION).jar:
	mkdir -p $(ORIGIN_BASE)
	wget -c -O $(ORIGIN_BASE)/ecjsrc-$(ECJ_VERSION).jar https://ftp-stud.hs-esslingen.de/Mirrors/eclipse/eclipse/downloads/drops4/R-4.26-202211231800/ecjsrc-$(ECJ_VERSION).jar
	
$(ORIGIN_BASE)/bnd-$(BND_VERSION).tar.gz:
	mkdir -p $(ORIGIN_BASE)
	wget -c -O $(ORIGIN_BASE)/bnd-$(BND_VERSION).tar.gz https://github.com/bndtools/bnd/archive/refs/tags/$(BND_VERSION).REL.tar.gz

all: ecj-build bndlib-build	
	make -C org.argeo.tp.build all

ecj: ecj-build

ecj-build:
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
	# list sources
	find $(ECJ_BASE)/org | grep "\.java" > $(BOOTSTRAP_BASE)/ecj.todo
	# copy sources
	mkdir -p $(ECJ_SRC)
	cp -r $(ECJ_BASE)/org $(ECJ_SRC)
	# build
	$(JAVA_HOME)/bin/javac -d $(ECJ_BASE) -source 17 -target 17 -Xlint:none @$(BOOTSTRAP_BASE)/ecj.todo
	# remove sources
	cd $(ECJ_BASE) && find . -name "*.java" -name "*.html" -type f -exec rm -f {} \;
	
bndlib-build: ecj-build
	# copy sources
	cd $(BOOTSTRAP_BASE) && tar -xzf $(ORIGIN_BASE)/bnd-$(BND_VERSION).tar.gz
	mkdir -p $(BNDLIB_SRC)
	cp -r $(BOOTSTRAP_BASE)/bnd-$(BND_VERSION).REL/aQute.libg/src/* $(BNDLIB_SRC)
	cp -r $(BOOTSTRAP_BASE)/bnd-$(BND_VERSION).REL/biz.aQute.bndlib/src/* $(BNDLIB_SRC)
	cp -r $(BOOTSTRAP_BASE)/bnd-$(BND_VERSION).REL/biz.aQute.bnd.annotation/src/* $(BNDLIB_SRC)	
	rm -rf $(BOOTSTRAP_BASE)/bnd-$(BND_VERSION).REL
	
	# clean up
	rm -rf $(BNDLIB_SRC)/aQute/bnd/junit
	
	# build
	$(JAVA_HOME)/bin/java -cp $(ECJ_BASE) org.eclipse.jdt.internal.compiler.batch.Main -nowarn \
		-cp $(BND_CLASSPATH) \
		-source 17 -target 17 \
		$(BNDLIB_SRC) \
		-d $(BNDLIB_BASE)
	

clean:
	rm -rf $(BOOTSTRAP_BASE)
	make -C org.argeo.tp.build clean
