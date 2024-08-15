include ../../sdk.mk
.PHONY: clean all osgi

export NO_SDK_LEGAL := true

A2_CATEGORY = org.argeo.tp.ml

## FIXME - DON'T FORGET TO UPDATE THE VERSION IN THE RELATED bnd.bnd FILE!
JLLAMA_BRANCH=3.3
JLLAMA_VERSION=$(JLLAMA_BRANCH).0

LLAMA3_COMMIT=5f602500beb593dce2726df7e2dd08b0803aa86b
LLAMA3_VERSION=0.1.0

all: retrieve-jllama retrieve-llama3 osgi
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

retrieve-llama3: SRC_DIR=com.llama4j/src/com/llama4j
retrieve-llama3:
	rm -rf $(SRC_DIR)
	mkdir -p $(SRC_DIR)
	git clone https://github.com/mukel/llama3.java.git $(SRC_DIR)
	git -C $(SRC_DIR) checkout $(LLAMA3_COMMIT)
	rm -rf $(SRC_DIR)/.git

BUNDLES = \
de.kherud.llama \
com.llama4j \

clean:
	rm -rf $(BUILD_BASE)

include $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk
