include ../../sdk.mk
.PHONY: clean all osgi

all: osgi

A2_CATEGORY = org.argeo.tp

BUNDLES = \
org.argeo.ext.slf4j \

clean:
	rm -rf $(BUILD_BASE)

DEP_CATEGORIES = org.argeo.tp

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk