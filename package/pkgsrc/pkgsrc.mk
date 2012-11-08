#####################################
#
# NetBSD package collection (pkgsrc)
#
#####################################

ifeq ($(BR2_PKGSRC),y)

PKGSRC_VERSION =$(BR2_PKGSRC_VERSION)
PKGSRC_SOURCE_DIR :=$(BUILD_DIR)/host-pkgsrc-$(PKGSRC_VERSION)/pkgsrc
PKGSRC_HOST_DIR := $(HOST_DIR)/pkgsrc-$(PKGSRC_VERSION)
PKGSRC_DEST_DIR := $(TARGET_DIR)/$(BR2_PKGSRC_TARGET_PREFIX)
PKGSRC_PACKAGE_DIR := $(BASE_DIR)/../package/pkgsrc

ifeq ($(BR2_CCACHE),y)
	PKGSRC_COMPILER = ccache gcc
else
	PKGSRC_COMPILER = gcc
endif

include package/pkgsrc/host-pkgsrc.mk.in
include package/pkgsrc/target-pkgsrc.mk.in


endif # BR2_PKGSRC
