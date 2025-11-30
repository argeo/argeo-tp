include sdk.mk
.PHONY: clean all bootstrap

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
	mkdir -p $(A2_OUTPUT)/lib/aarch64-macos-default/org.argeo.tp.desktop
	cp -a $(A2_OUTPUT)/lib/x86_64-macos-default/org.argeo.tp.desktop/* $(A2_OUTPUT)/lib/aarch64-macos-default/org.argeo.tp.desktop
	mkdir -p $(A2_OUTPUT)/lib/aarch64-macos-default/jmods/com.jogamp.jni/lib
	cp -a $(A2_OUTPUT)/lib/x86_64-macos-default/jmods/com.jogamp.jni/lib/* $(A2_OUTPUT)/lib/aarch64-macos-default/jmods/com.jogamp.jni/lib
	
package-jmods:
	$(JAVA_HOME)/bin/java sdk/argeo-build/src/org/argeo/build/PackageJmods.java $(A2_OUTPUT)
	
clean:
	make -C repackage clean
	make -C rebuild clean

native-deps-debian:
	sudo apt -y install rsync liblockfile-dev

native-deps-msys2:
	pacman --noconfirm rsync

clean-origin-cache:
	rm -rf $(HOME)/.cache/argeo/build

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk