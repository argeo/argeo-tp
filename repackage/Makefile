include ../sdk.mk
.PHONY: clean all

all: distribution

BOOTSTRAP_BASE=$(SDK_BUILD_BASE)/bootstrap

A2_OUTPUT = $(SDK_BUILD_BASE)/a2

CATEGORIES=\
org.argeo.tp.sdk \
osgi/api/org.argeo.tp.osgi \
osgi/equinox/org.argeo.tp.osgi \
osgi/equinox/org.argeo.tp.eclipse \
swt/rap/org.argeo.tp.swt \
swt/rap/org.argeo.tp.swt.workbench \
swt/rcp/org.argeo.tp.swt \
lib/linux/x86_64/swt/rcp/org.argeo.tp.swt \
lib/linux/aarch64/swt/rcp/org.argeo.tp.swt \
lib/win32/x86_64/swt/rcp/org.argeo.tp.swt \
lib/macosx/x86_64/swt/rcp/org.argeo.tp.swt \
swt/rcp/org.argeo.tp.swt \
swt/rcp/org.argeo.tp.swt.workbench \
org.argeo.tp \
org.argeo.tp.apache \
org.argeo.tp.jetty \
org.argeo.tp.jcr \
org.argeo.tp.formats \
org.argeo.tp.poi \
org.argeo.tp.gis \


distribution:
	$(JVM) -cp \
	 $(BOOTSTRAP_BASE)/bndlib.jar:$(BOOTSTRAP_BASE)/slf4j-api.jar:$(BOOTSTRAP_BASE)/org.argeo.slc.api/bin:$(BOOTSTRAP_BASE)/org.argeo.slc.factory/bin \
	 $(SDK_SRC_BASE)/sdk/argeo-build/src/org/argeo/build/Repackage.java $(A2_OUTPUT) $(CATEGORIES)

clean:
	rm -rf $(A2_OUTPUT)/org.argeo.tp
	rm -rf $(A2_OUTPUT)/org.argeo.tp.*
	rm -rf $(A2_OUTPUT)/*/org.argeo.tp
	rm -rf $(A2_OUTPUT)/*/org.argeo.tp.*
	rm -rf $(A2_OUTPUT)/*/*/org.argeo.tp
	rm -rf $(A2_OUTPUT)/*/*/org.argeo.tp.*
	rm -rf $(A2_OUTPUT)/*/*/*/org.argeo.tp
	rm -rf $(A2_OUTPUT)/*/*/*/org.argeo.tp.*
	rm -rf $(A2_OUTPUT)/*/*/*/*/org.argeo.tp
	rm -rf $(A2_OUTPUT)/*/*/*/*/org.argeo.tp.*

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk