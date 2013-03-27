include theos/makefiles/common.mk

TWEAK_NAME = ShareforMobileSafari
ShareforSafari_FILES = Tweak.xm
ShareforSafari_FRAMEWORKS = Twitter UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
