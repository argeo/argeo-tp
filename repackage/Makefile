include ../sdk.mk

# Minimal third-parties for running headless Argeo CMS
CATEGORIES_CMS=\
org.argeo.tp \
org.argeo.tp.httpd \
crypto/fips/org.argeo.tp.crypto \
org.argeo.tp.sshd \
osgi/equinox/org.argeo.tp.osgi.framework \
osgi/equinox/org.argeo.tp.osgi \
osgi/equinox/org.argeo.tp.eclipse \

CATEGORIES=\
$(CATEGORIES_CMS) \
org.argeo.tp.sys \
org.argeo.tp.sdk \
osgi/api/org.argeo.tp.osgi \
swt/rap/org.argeo.tp.swt \
swt/rap/org.argeo.tp.swt.workbench \
swt/rcp/org.argeo.tp.swt \
lib/linux/x86_64/org.argeo.tp.sys \
lib/linux/aarch64/org.argeo.tp.sys \
lib/win32/x86_64/org.argeo.tp.sys \
lib/macosx/x86_64/org.argeo.tp.sys \
lib/linux/x86_64/swt/rcp/org.argeo.tp.swt \
lib/linux/aarch64/swt/rcp/org.argeo.tp.swt \
lib/win32/x86_64/swt/rcp/org.argeo.tp.swt \
lib/macosx/x86_64/swt/rcp/org.argeo.tp.swt \
lib/macosx/x86_64/swt/rcp/org.argeo.tp.swt.workbench \
swt/rcp/org.argeo.tp.swt \
swt/rcp/org.argeo.tp.swt.workbench \
org.argeo.tp.utils \
org.argeo.tp.img \
org.argeo.tp.publish \
org.argeo.tp.math \
org.argeo.tp.jcr \
org.argeo.tp.office \
org.argeo.tp.earth \
crypto/full/org.argeo.tp.crypto \

install-for-minimal-cms:
	$(MAKE) install CATEGORIES="$(CATEGORIES_CMS)"

include  $(SDK_SRC_BASE)/sdk/argeo-build/repackage.mk