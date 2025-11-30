include ../sdk.mk

# Minimal third-parties for running headless Argeo CMS
CATEGORIES_CMS=\
org.argeo.tp \
org.argeo.tp.httpd \
crypto/fips/org.argeo.tp.crypto \
org.argeo.tp.sshd \
osgi/api/org.argeo.tp.osgi.framework \
osgi/org.argeo.tp.osgi \

CATEGORIES=\
$(CATEGORIES_CMS) \
org.argeo.tp.sys \
lib/org.argeo.tp.sys \
org.argeo.tp.sdk \
org.argeo.tp.desktop \
lib/org.argeo.tp.desktop \
osgi/equinox/org.argeo.tp.osgi.framework \
osgi/equinox/org.argeo.tp.osgi \
osgi/equinox/org.argeo.tp.eclipse \
osgi/equinox/org.argeo.tp.p2 \
swt/rap/org.argeo.tp.swt \
swt/rap/org.argeo.tp.swt.workbench \
swt/rcp/org.argeo.tp.swt \
swt/rcp/org.argeo.tp.swt.workbench \
org.argeo.tp.utils \
org.argeo.tp.img \
org.argeo.tp.publish \
org.argeo.tp.math \
org.argeo.tp.jcr \
org.argeo.tp.office \
org.argeo.tp.earth \
org.argeo.tp.ml \
crypto/full/org.argeo.tp.crypto \
lib/x86_64-linux-gnu/swt/rcp/org.argeo.tp.swt \
lib/aarch64-linux-gnu/swt/rcp/org.argeo.tp.swt \
lib/x86_64-win32-default/swt/rcp/org.argeo.tp.swt \
lib/aarch64-win32-default/swt/rcp/org.argeo.tp.swt \
lib/x86_64-macos-default/swt/rcp/org.argeo.tp.swt \
lib/aarch64-macos-default/swt/rcp/org.argeo.tp.swt \
lib/x86_64-linux-gnu/osgi/equinox/org.argeo.tp.eclipse \
lib/aarch64-linux-gnu/osgi/equinox/org.argeo.tp.eclipse \
lib/x86_64-win32-default/osgi/equinox/org.argeo.tp.eclipse \
lib/aarch64-win32-default/osgi/equinox/org.argeo.tp.eclipse \
lib/x86_64-macos-default/osgi/equinox/org.argeo.tp.eclipse \
lib/aarch64-macos-default/osgi/equinox/org.argeo.tp.eclipse \


install-for-minimal-cms:
	$(MAKE) install CATEGORIES="$(CATEGORIES_CMS)"

include  $(SDK_SRC_BASE)/sdk/argeo-build/repackage.mk