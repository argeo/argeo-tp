include sdk.mk
.PHONY: clean all

all: distribution

BOOTSTRAP_BASE=$(SDK_BUILD_BASE)/bootstrap

A2_OUTPUT = $(SDK_BUILD_BASE)/a2

distribution: bootstrap
	make -C repackage all
	make -C rebuild all
	
bootstrap :
	mkdir -p $(SDK_BUILD_BASE)/bootstrap
	wget -c -O $(BOOTSTRAP_BASE)/ecj.jar https://repo1.maven.org/maven2/org/eclipse/jdt/ecj/3.32.0/ecj-3.32.0.jar
	wget -c -O $(BOOTSTRAP_BASE)/slf4j-api.jar https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.36/slf4j-api-1.7.36.jar
	wget -c -O $(BOOTSTRAP_BASE)/bndlib.jar https://repo1.maven.org/maven2/biz/aQute/bnd/biz.aQute.bndlib/5.3.0/biz.aQute.bndlib-5.3.0.jar

clean:
	rm -rf $(BOOTSTRAP_BASE)
	make -C repackage clean
	make -C rebuild clean

clean-origin-cache:
	rm -rf $(HOME)/.cache/argeo/build

include  $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk