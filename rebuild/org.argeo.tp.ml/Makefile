include ../../sdk.mk
.PHONY: clean all osgi

export NO_SDK_LEGAL := true

A2_CATEGORY = org.argeo.tp.ml

JLAMA_JNI_SRC=jni/com_github_tjake_jlama
JLAMA_TARGET_EXEC=libjlama.so

## FIXME - DON'T FORGET TO UPDATE THE VERSION IN THE RELATED bnd.bnd FILE!
JLLAMA_BRANCH=3.3
JLLAMA_VERSION=$(JLLAMA_BRANCH).0

LLAMA3_COMMIT=5f602500beb593dce2726df7e2dd08b0803aa86b
LLAMA3_VERSION=0.1.0

JLAMA_BRANCH=0.2
JLAMA_VERSION=$(JLAMA_BRANCH).1

all: retrieve-jllama retrieve-llama3 retrieve-jlama osgi jni-jlama
	mkdir -p $(SDK_BUILD_BASE)/a2/$(TARGET_ARCH_CATEGORY_PREFIX)/$(A2_CATEGORY)
	mv $(SDK_BUILD_BASE)/a2/$(A2_CATEGORY)/de.kherud.llama.$(JLLAMA_BRANCH).jar $(SDK_BUILD_BASE)/a2/$(TARGET_ARCH_CATEGORY_PREFIX)/$(A2_CATEGORY)
	mv $(SDK_BUILD_BASE)/a2/$(A2_CATEGORY)/com.github.tjake.jlama.native.$(JLAMA_BRANCH).jar $(SDK_BUILD_BASE)/a2/$(TARGET_ARCH_CATEGORY_PREFIX)/$(A2_CATEGORY)

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

retrieve-jlama: SRC_DIR=src/jlama
retrieve-jlama:
	rm -rf $(SRC_DIR)
	mkdir -p $(SRC_DIR)
	git clone --branch v$(JLAMA_VERSION) https://github.com/tjake/Jlama.git $(SRC_DIR)
	rm -rf $(SRC_DIR)/.git
	rsync -a --delete --exclude module-info.java $(SRC_DIR)/jlama-native/src/main/java/ com.github.tjake.jlama.native/src
	# future: rsync -a --delete --exclude module-info.java $(SRC_DIR)/jlama-native/src/main/java21/ com.github.tjake.jlama.native/src
	rsync -a --delete --exclude module-info.java $(SRC_DIR)/jlama-native/src/main/c/ $(JLAMA_JNI_SRC)

BUNDLES = \
de.kherud.llama \
com.llama4j \
com.github.tjake.jlama.native \


clean:
	rm -rf $(BUILD_BASE)

DEP_CATEGORIES = \
log/syslogger/org.argeo.tp \
org.argeo.tp.ml

include $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk

A2_NATIVE_CATEGORY=$(A2_OUTPUT)/lib/linux/$(shell uname -m)/$(A2_CATEGORY)

jni-jlama:
	mkdir -p $(A2_NATIVE_CATEGORY)
	$(CC) -o $(A2_NATIVE_CATEGORY)/$(JLAMA_TARGET_EXEC) \
	 -O3 -mavx2 -march=native -Werror -Wno-attributes -fPIC -fno-omit-frame-pointer -Wunused-variable \
	 -shared -fPIC -fpic -Wl,-soname,$(JLAMA_TARGET_EXEC).$(JLAMA_BRANCH) \
	 -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux $(JLAMA_JNI_SRC)/*.c
