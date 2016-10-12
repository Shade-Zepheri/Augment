include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Augment
Augment_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += augment
include $(THEOS_MAKE_PATH)/aggregate.mk
