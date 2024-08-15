include ../../sdk.mk
.PHONY: clean all osgi

export NO_SDK_LEGAL := true

A2_CATEGORY = org.argeo.tp.ml

## FIXME - DON'T FORGET TO UPDATE THE VERSION IN THE RELATED bnd.bnd FILE!
JLLAMA_BRANCH=3.3
JLLAMA_VERSION=$(JLLAMA_BRANCH).0

all: retrieve-jllama osgi
	mkdir -p $(SDK_BUILD_BASE)/a2/$(TARGET_ARCH_CATEGORY_PREFIX)/$(A2_CATEGORY)
	mv $(SDK_BUILD_BASE)/a2/$(A2_CATEGORY)/de.kherud.llama.$(JLLAMA_BRANCH).jar $(SDK_BUILD_BASE)/a2/$(TARGET_ARCH_CATEGORY_PREFIX)/$(A2_CATEGORY)

install:
	mkdir -p $(A2_NATIVE_INSTALL_TARGET)/$(A2_CATEGORY)
	$(INSTALL) $(A2_NATIVE_INSTALL_TARGET)/$(A2_CATEGORY) $(SDK_BUILD_BASE)/a2/$(TARGET_ARCH_CATEGORY_PREFIX)/$(A2_CATEGORY)/de.kherud.llama.$(JLLAMA_BRANCH).jar
	
uninstall: osgi-uninstall
	@if [ -d $(A2_NATIVE_INSTALL_TARGET) ]; then find $(A2_NATIVE_INSTALL_TARGET) -empty -type d -delete; fi

retrieve-jllama: SRC_DIR=src/jllama
retrieve-jllama:
	rm -rf $(SRC_DIR)
	mkdir -p $(SRC_DIR)
	git clone --branch v$(JLLAMA_VERSION) https://github.com/kherud/java-llama.cpp.git $(SRC_DIR)
	rm -rf $(SRC_DIR)/.git
	rsync -a --delete --exclude module-info.java $(SRC_DIR)/src/main/java/ de.kherud.llama/src
	# diff -crB src/jllama/src/main/java de.kherud.llama/src > remove-jetbrain-annotations.patch
	patch -p0 < remove-jetbrain-annotations.patch 

BUNDLES = \
de.kherud.llama \

clean:
	rm -rf $(BUILD_BASE)

include $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk
