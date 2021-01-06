include $(THEOS)/makefiles/common.mk

TOOL_NAME = appinfo
appinfo_FILES = main.m
appinfo_FRAMEWORKS = MobileCoreServices
appinfo_CODESIGN_FLAGS = -Sents.xml

include $(THEOS_MAKE_PATH)/tool.mk
