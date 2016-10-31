include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Augment
Augment_FILES = $(wildcard tweak/*.m tweak/*.mm tweak/*.x tweak/*.xm)
Augment_FRAMEWORKS = UIKit
Augment_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += augment
include $(THEOS_MAKE_PATH)/aggregate.mk
