export THEOS_PACKAGE_DIR_NAME = debs
export ARCHS = arm64 armv7 armv7s

include theos/makefiles/common.mk

TWEAK_NAME = HeadphoneStatus
HeadphoneStatus_FILES = Tweak.xm
HeadphoneStatus_PRIVATE_FRAMEWORKS = Celestial TelephonyUtilities

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
