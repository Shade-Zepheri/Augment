include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = augment
augment_FILES = AUGRootListController.m
augment_INSTALL_PATH = /Library/PreferenceBundles
augment_FRAMEWORKS = UIKit
augment_PRIVATE_FRAMEWORKS = Preferences
augment_CFLAGS += -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/augment.plist$(ECHO_END)
