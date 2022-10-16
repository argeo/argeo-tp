include ../../sdk.mk
.PHONY: clean all osgi

all: prepare osgi

prepare:
	rsync -a --exclude module-info.java $(SDK_SRC_BASE)/src/org.argeo.tp/ee4j-mail/mbox/src/main/java/ com.sun.mail.mbox/src

A2_CATEGORY = org.argeo.tp

BUNDLES = \
org.argeo.ext.slf4j \
com.sun.mail.mbox \

clean:
	rm -rf $(BUILD_BASE)

DEP_CATEGORIES = org.argeo.tp

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk