include ../../sdk.mk

.PHONY: clean all osgi

# !! Update *.bnd files when updating the submodule

A2_CATEGORY = org.argeo.tp.desktop

BUNDLES = \
gov.nasa.worldwind \
gov.nasa.worldwind.symbology \
gov.nasa.worldwindx \

DEP_CATEGORIES = \
org.argeo.tp.desktop \
lib/org.argeo.tp.desktop \
org.argeo.tp.sys

all: retrieve-worldwind osgi

clean:
	rm -rf $(BUILD_BASE)
#	$(foreach bundle,$(BUNDLES),rm -rf $(bundle)/src)
	$(foreach bundle,$(BUNDLES),rm -rf $(bundle)/META-INF/MANIFEST.MF)

retrieve-worldwind: SRC_DIR=src/WorldWindJava
retrieve-worldwind:
	mkdir -p \
		gov.nasa.worldwind/src \
		gov.nasa.worldwindx/src/gov/nasa/worldwindx \
		gov.nasa.worldwind.symbology/src/gov/nasa/worldwind/symbology/milstd2525
	
	rsync -a --delete \
		--exclude "*/worldwindx/*" \
		--exclude "*/overview.html" \
		$(SRC_DIR)/src/ gov.nasa.worldwind/src
	rm -rv gov.nasa.worldwind/src/gov/nasa/worldwind/util/gdal
	rm -v gov.nasa.worldwind/src/gov/nasa/worldwind/data/GDAL*
	patch -p0 -i worldwind-earth-remove-gdal.patch
	
	rsync -a --delete \
		$(SRC_DIR)/src/gov/nasa/worldwindx/ gov.nasa.worldwindx/src/gov/nasa/worldwindx

# VPF original archive is hard to find:
# https://nsgreg.nga.mil/doc/view?i=2286
# and uses an old vector format (CGM). Maybe it can be converted with:
# https://github.com/sk1project/uniconvertor
# or https://darrengoossens.wordpress.com/2019/01/03/open-or-convert-a-cgm-computer-graphics-metafile-in-linux-and-a-deb-file-to-help/
	rm -rf gov.nasa.worldwind.symbology/src/geosym
	unzip -q $(SRC_DIR)/vpf-symbols.jar "geosym/*" -d "gov.nasa.worldwind.symbology/src/"

	rsync -a --delete \
		gov.nasa.worldwind/src/gov/nasa/worldwind/symbology/ \
		gov.nasa.worldwind.symbology/src/gov/nasa/worldwind/symbology
	rm -rf gov.nasa.worldwind/src/gov/nasa/worldwind/symbology/

	rsync -a \
		$(SRC_DIR)/milstd2525/ gov.nasa.worldwind.symbology/src/gov/nasa/worldwind/symbology/milstd2525

include $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk
		