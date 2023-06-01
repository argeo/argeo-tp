include ../sdk.mk

# Minimal third-parties for running headless Argeo CMS
CATEGORIES_CMS=\
osgi/equinox/org.argeo.tp.osgi \
org.argeo.tp \
org.argeo.tp.httpd \
crypto/fips/org.argeo.tp.crypto \
osgi/equinox/org.argeo.tp.eclipse \


CATEGORIES=\
$(CATEGORIES_CMS) \
org.argeo.tp.sdk \
osgi/api/org.argeo.tp.osgi \
swt/rap/org.argeo.tp.swt \
swt/rap/org.argeo.tp.swt.workbench \
swt/rcp/org.argeo.tp.swt \
lib/linux/x86_64/org.argeo.tp \
lib/linux/aarch64/org.argeo.tp \
lib/win32/x86_64/org.argeo.tp \
lib/macosx/x86_64/org.argeo.tp \
lib/linux/x86_64/swt/rcp/org.argeo.tp.swt \
lib/linux/aarch64/swt/rcp/org.argeo.tp.swt \
lib/win32/x86_64/swt/rcp/org.argeo.tp.swt \
lib/macosx/x86_64/swt/rcp/org.argeo.tp.swt \
lib/macosx/x86_64/swt/rcp/org.argeo.tp.swt.workbench \
swt/rcp/org.argeo.tp.swt \
swt/rcp/org.argeo.tp.swt.workbench \
org.argeo.tp.utils \
org.argeo.tp.publish \
org.argeo.tp.math \
org.argeo.tp.jcr \
org.argeo.tp.office \
org.argeo.tp.earth \
crypto/full/org.argeo.tp.crypto \

install-for-minimal-cms:
	$(MAKE) install CATEGORIES="$(CATEGORIES_CMS)"

include  $(SDK_SRC_BASE)/sdk/argeo-build/repackage.mk