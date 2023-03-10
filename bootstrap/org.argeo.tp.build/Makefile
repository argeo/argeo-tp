.PHONY: clean all osgi

A2_OUTPUT := $(SDK_BUILD_BASE)/a2
JVM ?= $(JAVA_HOME)/bin/java

ARGEO_MAKE := $(JVM) -cp  ../ecj:../bndlib ../sdk/argeo-build/src/org/argeo/build/Make.java

A2_CATEGORY = org.argeo.tp.build

all: osgi

osgi:
	cp -r ../ecj/OSGI-OPT/src org.eclipse.jdt.core.compiler.batch
	cp -r ../bndlib/OSGI-OPT/src biz.aQute.bndlib

	$(ARGEO_MAKE) all --category $(A2_CATEGORY) --bundles org.eclipse.jdt.core.compiler.batch biz.aQute.bndlib

clean:
	$(RM) -rf org.eclipse.jdt.core.compiler.batch/src
	$(RM) -rf biz.aQute.bndlib/src