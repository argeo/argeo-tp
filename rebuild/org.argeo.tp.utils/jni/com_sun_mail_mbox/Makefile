include ../../../../sdk.mk

NATIVE_PACKAGE := com_sun_mail_mbox

TARGET_EXEC := libJava_$(NATIVE_PACKAGE).so

# sudo apt install liblockfile-dev

build:
	mkdir -p $(SDK_BUILD_BASE)/jni
	$(CC) -o $(SDK_BUILD_BASE)/jni/$(TARGET_EXEC) -shared -fPIC -fpic -Wl,-soname,$(TARGET_EXEC).1.6 -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux *.c
