#####################################
#
# NetBSD package collection (pkgsrc)
#
#####################################

ifeq ($(BR2_PKGSRC),y)

PKGSRC_VERSION = $(BR2_PKGSRC_VERSION)
PKGSRC_SOURCE_DIR := $(BUILD_DIR)/host-pkgsrc-$(PKGSRC_VERSION)
PKGSRC_HOST_DIR := $(HOST_DIR)/pkgsrc-$(PKGSRC_VERSION)

include package/pkgsrc/host-pkgsrc.mk.in
include package/pkgsrc/target-pkgsrc.mk.in

endif # BR2_PKGSRC
