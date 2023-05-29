include sdk.mk
.PHONY: clean all bootstrap

all: distribution

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
	
clean:
	make -C repackage clean
	make -C rebuild clean

native-deps-debian:
	sudo apt install liblockfile-dev

clean-origin-cache:
	rm -rf $(HOME)/.cache/argeo/build

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk