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
org.argeo.tp.sys

all: retrieve-worldwind osgi

clean:
	rm -rf $(BUILD_BASE)
	$(foreach bundle,$(BUNDLES),rm -rf $(bundle)/src)
	$(foreach bundle,$(BUNDLES),rm -rf $(bundle)/META-INF/MANIFEST.MF)

retrieve-worldwind: SRC_DIR=src/WorldWindJava
retrieve-worldwind:
	mkdir -p \
		gov.nasa.worldwind/src/gov/nasa/worldwind \
		gov.nasa.worldwind/src/com/zebraimaging \
		gov.nasa.worldwind/src/org/codehaus \
		gov.nasa.worldwindx/src/gov/nasa/worldwindx \
		gov.nasa.worldwind.symbology/src/gov/nasa/worldwind/symbology/milstd2525
	
	rsync -a --delete \
		$(SRC_DIR)/src/gov/nasa/worldwind/ gov.nasa.worldwind/src/gov/nasa/worldwind
	rsync -a --delete \
		$(SRC_DIR)/src/com/zebraimaging/ gov.nasa.worldwind/src/com/zebraimaging
	rsync -a --delete \
		$(SRC_DIR)/src/org/codehaus/ gov.nasa.worldwind/src/org/codehaus
	patch -p0 < wordlwind-gdal.patch
	
	rsync -a --delete \
		$(SRC_DIR)/src/gov/nasa/worldwindx/ gov.nasa.worldwindx/src/gov/nasa/worldwindx

	unzip -q $(SRC_DIR)/vpf-symbols.jar "geosym/*" -d "gov.nasa.worldwind.symbology/src/"
	rsync -a --delete \
		$(SRC_DIR)/milstd2525/ gov.nasa.worldwind.symbology/src/gov/nasa/worldwind/symbology/milstd2525


include $(SDK_SRC_BASE)/sdk/argeo-build/osgi.mk
		