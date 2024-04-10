include ../../sdk.mk
.PHONY: clean all osgi

export NO_SDK_LEGAL := true

A2_CATEGORY = org.argeo.tp.sys

MBOX_JNI_SRC=jni/org_eclipse_angus_mail_mbox
MBOX_TARGET_EXEC=libmbox.so

## FIXME - DON'T FORGET TO UPDATE THE VERSION IN THE RELATED bnd.bnd FILE!
ANGUS_BRANCH=2.0
ANGUS_VERSION=$(ANGUS_BRANCH).3

all: retrieve-angus-mbox osgi jni-angus-mbox

install:
	mkdir -p $(A2_NATIVE_INSTALL_TARGET)/$(A2_CATEGORY)
	# Angus mbox
	$(INSTALL) $(A2_NATIVE_INSTALL_TARGET)/$(A2_CATEGORY) $(SDK_BUILD_BASE)/a2/$(A2_CATEGORY)/org.eclipse.angus.mail.mbox.$(ANGUS_BRANCH).jar
	#$(INSTALL) $(A2_NATIVE_INSTALL_TARGET) $(A2_NATIVE_CATEGORY)/$(MBOX_TARGET_EXEC)
	
uninstall: osgi-uninstall
	#$(RM) $(A2_NATIVE_INSTALL_TARGET)/$(MBOX_TARGET_EXEC)
	@if [ -d $(A2_NATIVE_INSTALL_TARGET) ]; then find $(A2_NATIVE_INSTALL_TARGET) -empty -type d -delete; fi

retrieve-angus-mbox: SRC_DIR=src/angus-mail
retrieve-angus-mbox:
	rm -rf $(SRC_DIR)
	mkdir -p $(SRC_DIR)
#git -C $(SRC_DIR) init
#git -C $(SRC_DIR) remote add -f origin https://github.com/eclipse-ee4j/mail.git
#git -C $(SRC_DIR) config core.sparseCheckout true
#echo "mbox" >> $(SRC_DIR)/.git/info/sparse-checkout
#git -C $(SRC_DIR) pull origin 1.6.7
	git clone --branch $(ANGUS_VERSION) https://github.com/eclipse-ee4j/angus-mail.git $(SRC_DIR)
	rm -rf $(SRC_DIR)/.git
	rsync -a --delete --exclude module-info.java $(SRC_DIR)/providers/mbox/src/main/java/ org.eclipse.angus.mail.mbox/src
	# jni
	rsync -a $(SRC_DIR)/providers/mbox/src/main/cpp/org/eclipse/angus/mail/mbox/ $(MBOX_JNI_SRC)
	mkdir -p org.eclipse.angus.mail.mbox/bin
	javac -h $(MBOX_JNI_SRC) -cp "$(A2_OUTPUT)/org.argeo.tp.sys/*" org.eclipse.angus.mail.mbox/src/org/eclipse/angus/mail/mbox/*.java
	rm -rf org.eclipse.angus.mail.mbox/bin


BUNDLES = \
org.eclipse.angus.mail.mbox \

clean:
	rm -rf $(BUILD_BASE)

DEP_CATEGORIES = org.argeo.tp.sys

include $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk

A2_NATIVE_CATEGORY=$(A2_OUTPUT)/lib/linux/$(shell uname -m)/$(A2_CATEGORY)

jni-angus-mbox:
	mkdir -p $(A2_NATIVE_CATEGORY)
	$(CC) -o $(A2_NATIVE_CATEGORY)/$(MBOX_TARGET_EXEC) \
	 -shared -fPIC -fpic -Wl,-soname,$(MBOX_TARGET_EXEC).$(ANGUS_BRANCH) \
	 -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux $(MBOX_JNI_SRC)/*.c

