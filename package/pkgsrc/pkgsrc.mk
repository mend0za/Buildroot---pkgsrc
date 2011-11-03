#####################################
#
# NetBSD package collection (pkgsrc)
#
#####################################

ifeq ($(BR2_PKGSRC),y)

PKGSRC_VERSION = $(BR2_PKGSRC_VERSION)
PKGSRC_SOURCE_DIR := $(BUILD_DIR)/pkgsrc-$(PKGSRC_VERSION)
PKGSRC_HOST_DIR := $(HOST_DIR)/pkgsrc-$(PKGSRC_VERSION)
PKGSRC_DEST_DIR := $(TARGET_DIR)/usr/pkg

include package/pkgsrc/host-pkgsrc.mk.in
include package/pkgsrc/packages.mk.in

endif # BR2_PKGSRC
