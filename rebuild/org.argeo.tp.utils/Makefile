include ../../sdk.mk
.PHONY: clean all osgi

export NO_SDK_LEGAL := true

MBOX_JNI_SRC=jni/com_sun_mail_mbox
MBOX_TARGET_EXEC=libmbox.so

all: retrieve-ee4j-mbox osgi jni-ee4j-mbox

retrieve-ee4j-mbox: SRC_DIR=src/ee4j-mail
retrieve-ee4j-mbox:
	rm -rf $(SRC_DIR)
	mkdir -p $(SRC_DIR)
	#git -C $(SRC_DIR) init
	#git -C $(SRC_DIR) remote add -f origin https://github.com/eclipse-ee4j/mail.git
	#git -C $(SRC_DIR) config core.sparseCheckout true
	#echo "mbox" >> $(SRC_DIR)/.git/info/sparse-checkout
	#git -C $(SRC_DIR) pull origin 1.6.7
	git clone --branch 1.6.7 https://github.com/eclipse-ee4j/mail.git $(SRC_DIR)
	rm -rf $(SRC_DIR)/.git
	rsync -a --delete --exclude module-info.java $(SRC_DIR)/mbox/src/main/java/ com.sun.mail.mbox/src
	# jni
	rsync -a $(SRC_DIR)/mbox/src/main/cpp/com/sun/mail/mbox/ $(MBOX_JNI_SRC)
	mkdir -p com.sun.mail.mbox/bin
	javac -h jni/com_sun_mail_mbox/ -cp "$(A2_OUTPUT)/org.argeo.tp.utils/*" com.sun.mail.mbox/src/com/sun/mail/mbox/*.java
	rm -rf com.sun.mail.mbox/bin

jni-ee4j-mbox:
	mkdir -p $(A2_OUTPUT)/lib/linux/x86_64/$(A2_CATEGORY)
	$(CC) -o $(A2_OUTPUT)/lib/linux/x86_64/$(A2_CATEGORY)/$(MBOX_TARGET_EXEC) \
	 -shared -fPIC -fpic -Wl,-soname,$(MBOX_TARGET_EXEC).1.6 \
	 -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux $(MBOX_JNI_SRC)/*.c

A2_CATEGORY = org.argeo.tp.utils

BUNDLES = \
com.sun.mail.mbox \

clean:
	rm -rf $(BUILD_BASE)

DEP_CATEGORIES = org.argeo.tp.utils

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk