include ../sdk.mk
.PHONY: clean all

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
lib/macosx/x86_64/swt/rcp/org.argeo.tp.swt.workbench \
swt/rcp/org.argeo.tp.swt \
swt/rcp/org.argeo.tp.swt.workbench \
org.argeo.tp \
org.argeo.tp.apache \
org.argeo.tp.jetty \
org.argeo.tp.jcr \
org.argeo.tp.formats \
org.argeo.tp.poi \
org.argeo.tp.gis \

TODOS_REPACKAGE = $(foreach category, $(CATEGORIES),$(BUILD_BASE)/$(category)/to-repackage) 

BUILD_BASE = $(SDK_BUILD_BASE)/$(shell basename $(SDK_SRC_BASE))

all: $(BUILD_BASE)/repackaged 

.SECONDEXPANSION:

$(BUILD_BASE)/repackaged : CATEGORIES_TO_REPACKAGE = $(subst $(abspath $(BUILD_BASE))/,, $(subst to-repackage,, $?))
$(BUILD_BASE)/repackaged : $(TODOS_REPACKAGE)
	$(JVM) -cp \
	 $(BOOTSTRAP_BASE)/bndlib.jar:$(BOOTSTRAP_BASE)/slf4j-api.jar \
	 $(SDK_SRC_BASE)/sdk/argeo-build/src/org/argeo/build/Repackage.java $(A2_OUTPUT) $(CATEGORIES_TO_REPACKAGE)
	touch $(BUILD_BASE)/repackaged

$(BUILD_BASE)/%/to-repackage : $$(shell find % -type f )
	@rm -rf $(dir $@)
	@mkdir -p $(dir $@) 
	@touch $@

clean:
	$(foreach category, $(CATEGORIES), rm -rf $(A2_OUTPUT)/$(category))
	$(foreach category, $(CATEGORIES), rm -rf $(BUILD_BASE)/$(category))
	rm -f $(BUILD_BASE)/repackaged

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk