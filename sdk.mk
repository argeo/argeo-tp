SDK_SRC_BASE := /home/mbaudier/dev/git/unstable/argeo-tp
SDK_BUILD_BASE := /home/mbaudier/dev/git/unstable/output
JAVA_HOME := /opt/graalvm-ce/

include $(SDK_SRC_BASE)/branch.mk
include $(SDK_SRC_BASE)/sdk/branches/$(BRANCH).bnd
