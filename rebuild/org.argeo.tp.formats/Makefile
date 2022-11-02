include ../../sdk.mk
.PHONY: clean all osgi

all: retrieve-ee4j-mbox osgi

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

A2_CATEGORY = org.argeo.tp.utils

BUNDLES = \
com.sun.mail.mbox \

clean:
	rm -rf $(BUILD_BASE)

DEP_CATEGORIES = org.argeo.tp.utils

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk