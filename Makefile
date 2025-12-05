include sdk.mk
include sdk/argeo-build/jpms.mk

all: distribution package-jmods

install:
	make -C repackage install
	make -C rebuild install
	
uninstall:
	make -C repackage uninstall
	make -C rebuild uninstall
	

A2_OUTPUT = $(SDK_BUILD_BASE)/a2

distribution:
	make -C repackage all
	make -C rebuild all
	
	# jogamp Mac OS (universal libraries9
# TODO improve repackaging
	mkdir -p $(A2_OUTPUT)/lib/aarch64-macos-std/org.argeo.tp.desktop
	cp -a $(A2_OUTPUT)/lib/x86_64-macos-std/org.argeo.tp.desktop/* $(A2_OUTPUT)/lib/aarch64-macos-std/org.argeo.tp.desktop
	mkdir -p $(A2_OUTPUT)/lib/aarch64-macos-std/jmods/com.jogamp.jni/
	cp -a $(A2_OUTPUT)/lib/x86_64-macos-std/jmods/com.jogamp.jni/* $(A2_OUTPUT)/lib/aarch64-macos-std/jmods/com.jogamp.jni/

clean:
	make -C repackage clean
	make -C rebuild clean

native-deps-debian:
	sudo apt -y install rsync liblockfile-dev

native-deps-msys2:
	pacman --noconfirm rsync

#
# PACKAGING
#
JMOD_EQUINOX_FRAMEWORK=org.eclipse.osgi

package-jmods: jmods jmod-equinox-framework

jmod-equinox-framework:
	$(RM) $(A2_JMODS)/$(JMOD_EQUINOX_FRAMEWORK).jmod
	$(JLINK_HOME)/bin/jmod create \
	 --class-path "$(A2_OUTPUT)/osgi/equinox/org.argeo.tp.osgi.framework/*" \
	 $(A2_JMODS)/$(JLINK_JAVA_RELEASE)/$(JMOD_EQUINOX_FRAMEWORK).jmod


.PHONY: clean all

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk