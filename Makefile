export ARCHS = armv7 arm64
export SDKVERSION = 9.3
export TARGET = iphone:clang:9.3

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Augment
Augment_FILES = Tweak.xm
Augment_FRAMEWORKS = UIKit
Augment_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += augment
include $(THEOS_MAKE_PATH)/aggregate.mk
