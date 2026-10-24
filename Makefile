TARGET := iphone:clang:14.5:arm64
INSTALL_TARGET_PROCESSES = Standoff2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = StandoffMod

StandoffMod_FILES = Tweak.x
StandoffMod_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
