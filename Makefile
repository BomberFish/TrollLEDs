TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = TrollLEDs
ARCHS = arm64
PACKAGE_VERSION = 1.8.0

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = TrollLEDs

ifeq ($(UNSANDBOX),1)
	IPA_NAME = $(APPLICATION_NAME)-unsandboxed
else
	IPA_NAME = $(APPLICATION_NAME)
endif

$(APPLICATION_NAME)_FILES = $(wildcard *.m) $(wildcard *.swift)
$(APPLICATION_NAME)_FRAMEWORKS = SwiftUI CoreGraphics CoreMedia
$(APPLICATION_NAME)_CFLAGS = -fobjc-arc
ifeq ($(SANDBOX),1)
$(APPLICATION_NAME)_CODESIGN_FLAGS = -Sentitlements.plist
else
$(APPLICATION_NAME)_CODESIGN_FLAGS = -Sentitlements-unsandboxed.plist
endif

include $(THEOS_MAKE_PATH)/application.mk

ifeq ($(PACKAGE_FORMAT),ipa)
after-package::
	cp $(THEOS_PROJECT_DIR)/$(THEOS_PACKAGE_DIR)/$(THEOS_PACKAGE_NAME)_$(PACKAGE_VERSION).ipa $(THEOS_PROJECT_DIR)/$(IPA_NAME).tipa
endif
