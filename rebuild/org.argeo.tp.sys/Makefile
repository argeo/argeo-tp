include ../../sdk.mk
# Required first in order to use make conditionals
include $(SDK_SRC_BASE)/sdk/argeo-build/common.mk

.PHONY: clean all osgi

export NO_SDK_LEGAL := true

A2_CATEGORY = org.argeo.tp.sys

A2_NATIVE_CATEGORY=$(TARGET_NATIVE_CATEGORY)

BUNDLES = \
org.eclipse.angus.mail.mbox \
org.gdal \

DEP_CATEGORIES =\
org.argeo.tp \
org.argeo.tp.sys \

JAVAC = $(JAVA_HOME)/bin/javac

## !! DON'T FORGET TO UPDATE THE VERSION IN THE RELATED bnd.bnd FILE!

all: retrieve-angus-mbox jni-angus-mbox gdal osgi
#	mkdir -p $(SDK_BUILD_BASE)/a2/$(TARGET_ARCH_CATEGORY_PREFIX)/$(A2_CATEGORY)
#	mv $(SDK_BUILD_BASE)/a2/$(A2_CATEGORY)/org.eclipse.angus.mail.mbox.$(ANGUS_BRANCH).jar $(SDK_BUILD_BASE)/a2/$(TARGET_ARCH_CATEGORY_PREFIX)/$(A2_CATEGORY)

clean:
	rm -rf $(BUILD_BASE)/$(A2_CATEGORY)
#	$(foreach bundle,$(BUNDLES),rm -rf $(bundle)/src)
	$(foreach bundle,$(BUNDLES),rm -rf $(bundle)/META-INF/MANIFEST.MF)

install:
# TODO load versions from bnd files?
	mkdir -p $(A2_NATIVE_INSTALL_TARGET)
	# Angus mbox
	$(INSTALL) $(A2_INSTALL_TARGET)/$(A2_CATEGORY) $(A2_OUTPUT)/$(A2_CATEGORY)/org.eclipse.angus.mail.mbox.*.jar
	$(INSTALL) $(A2_NATIVE_INSTALL_TARGET)/$(A2_CATEGORY) $(TARGET_NATIVE_CATEGORY)/${MBOX_TARGET_EXEC}
	cd  $(A2_NATIVE_INSTALL_TARGET) && ln -fs $(A2_CATEGORY)/${MBOX_TARGET_EXEC}
	# GDAL
	$(INSTALL) $(A2_INSTALL_TARGET)/$(A2_CATEGORY) $(A2_OUTPUT)/$(A2_CATEGORY)/org.gdal.*.jar
	$(INSTALL) $(A2_NATIVE_INSTALL_TARGET)/$(A2_CATEGORY) $(TARGET_NATIVE_CATEGORY)/${GDAL_TARGET_EXEC}
	cd  $(A2_NATIVE_INSTALL_TARGET) && ln -fs $(A2_CATEGORY)/${GDAL_TARGET_EXEC}
	
uninstall:
	#$(RM) $(A2_NATIVE_INSTALL_TARGET)/$(MBOX_TARGET_EXEC)
	#@if [ -d $(A2_NATIVE_INSTALL_TARGET) ]; then find $(A2_NATIVE_INSTALL_TARGET) -empty -type d -delete; fi

#
# ANGUS MAIL
#
MBOX_JNI_SRC=jni/org_eclipse_angus_mail_mbox
MBOX_TARGET_EXEC=libmbox.so

retrieve-angus-mbox: SRC_DIR=src/angus-mail
retrieve-angus-mbox:
	rsync -a --delete --exclude module-info.java $(SRC_DIR)/providers/mbox/src/main/java/ org.eclipse.angus.mail.mbox/src
	# jni
	rsync -a --delete $(SRC_DIR)/providers/mbox/src/main/cpp/org/eclipse/angus/mail/mbox/ $(MBOX_JNI_SRC)
	mkdir -p org.eclipse.angus.mail.mbox/bin
	$(JAVAC) -h $(MBOX_JNI_SRC) \
	 -cp $(A2_OUTPUT)/org.argeo.tp/org.eclipse.angus.mail.2.0.jar:$(A2_OUTPUT)/org.argeo.tp/org.eclipse.angus.activation.2.0.jar \
	 org.eclipse.angus.mail.mbox/src/org/eclipse/angus/mail/mbox/*.java
	rm -rf org.eclipse.angus.mail.mbox/bin

jni-angus-mbox:
	echo TARGET_OS=$(TARGET_OS)
ifeq ($(TARGET_OS),linux)	
	mkdir -p $(A2_NATIVE_CATEGORY)
	$(CC) -o $(A2_NATIVE_CATEGORY)/$(MBOX_TARGET_EXEC) \
	 -shared -fPIC -fpic -Wl,-soname,$(MBOX_TARGET_EXEC) \
	 -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux $(MBOX_JNI_SRC)/*.c
	$(RM) $(TARGET_NATIVE_OUTPUT)/$(MBOX_TARGET_EXEC)
	cd $(TARGET_NATIVE_OUTPUT) && ln -s $(A2_CATEGORY)/$(MBOX_TARGET_EXEC) $(MBOX_TARGET_EXEC)
endif

#
# GDAL BINDINGS
#
GDAL_API_VERSION=36

ifeq ($(TARGET_OS),win32)
GDAL_TARGET_EXEC=libgdal-$(GDAL_API_VERSION).dll
GDAL_JNI_TARGET_EXEC=libgdalalljni.dll
else
GDAL_TARGET_EXEC=libgdal.so.$(GDAL_API_VERSION)
GDAL_JNI_TARGET_EXEC=libgdalalljni.so
endif

gdal: $(TARGET_NATIVE_OUTPUT)/$(GDAL_TARGET_EXEC) $(TARGET_NATIVE_OUTPUT)/$(GDAL_JNI_TARGET_EXEC) osgi

# Workaround so that GDAL is not rebuilt each time
# !! delete the shared library when updating
# TODO: make it more robust
$(TARGET_NATIVE_OUTPUT)/$(GDAL_TARGET_EXEC): jni-gdal
$(TARGET_NATIVE_OUTPUT)/$(GDAL_JNI_TARGET_EXEC): jni-gdal

jni-gdal: SRC_DIR=src/gdal
jni-gdal: BUILD_DIR=$(BUILD_BASE)/$(A2_CATEGORY)/gdal
jni-gdal:
	cmake -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=Release -DCMAKE_SKIP_INSTALL_RPATH=ON \
		-DBUILD_SHARED_LIBS=ON -DBUILD_APPS=OFF -DBUILD_TESTING=OFF \
		-DGDAL_USE_EXTERNAL_LIBS=ON -DGDAL_BUILD_OPTIONAL_DRIVERS=OFF -DOGR_BUILD_OPTIONAL_DRIVERS=OFF \
		-DENABLE_GNM=ON \
		-DBUILD_DOCS=OFF \
		-DBUILD_CSHARP_BINDINGS=OFF -DBUILD_PYTHON_BINDINGS=OFF \
		-DBUILD_JAVA_BINDINGS=ON -DGDAL_JAVA_GENERATE_JAVADOC=OFF \
		$(SRC_DIR)
	# TODO find a way not to rebuild everything
	cmake --build $(BUILD_DIR) -j $(shell nproc)

	# Main library goes directly to /lib, as it could be provided externally (by the Linux distribution)	
	cp $(BUILD_DIR)/$(GDAL_TARGET_EXEC) $(TARGET_NATIVE_OUTPUT)

	# JNI
	cp $(BUILD_DIR)/swig/java/$(GDAL_JNI_TARGET_EXEC) $(A2_NATIVE_CATEGORY)/$(GDAL_JNI_TARGET_EXEC)
	$(RM) $(TARGET_NATIVE_OUTPUT)/$(GDAL_JNI_TARGET_EXEC)
	cd $(TARGET_NATIVE_OUTPUT) && ln -s $(A2_CATEGORY)/$(GDAL_JNI_TARGET_EXEC) $(GDAL_JNI_TARGET_EXEC)

	# copy java sources
	mkdir -p org.gdal/src/org
	rsync -av --delete \
		--exclude "*.cpp" --exclude "*.c" \
		$(BUILD_DIR)/swig/java/org/ org.gdal/src/org

clean-gdal:
	$(RM) $(TARGET_NATIVE_OUTPUT)/$(GDAL_TARGET_EXEC)
	$(RM) $(TARGET_NATIVE_OUTPUT)/$(GDAL_JNI_TARGET_EXEC)
	$(RM) $(A2_NATIVE_CATEGORY)/$(GDAL_JNI_TARGET_EXEC)
	
	$(RM) -r $(BUILD_BASE)/$(A2_CATEGORY)/gdal

include $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk
		