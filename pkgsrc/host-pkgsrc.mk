#
# NetBSD package collection (pkgsrc)
# Host build support
#


PKGSRC_SITE = ftp://ftp.NetBSD.org/pub/pkgsrc/pkgsrc-$(PKGSRC_VERSION)
PKGSRC_SOURCE = pkgsrc-$(PKGSRC_VERSION).tar.gz
PKGSRC_INSTALL_STAGING = yes

PKGSRC_DEPENDENCIES = $(BASE_TARGETS) host-flex host-bison

PKGSRC_SH = /bin/bash


# TODO use HOSTCC with CCACHE (now broken on devel/bmake build)
define HOST_PKGSRC_BUILD_CMDS
	( cd $(PKGSRC_SOURCE_DIR)/bootstrap ; \
		export SH="$(PKGSRC_SH)" PATH="$(&HOST_DIR)/usr/bin:$(PATH)"; \
		export CC="$(HOSTCC_NOCCACHE)"; \
		./bootstrap \
			--unprivileged \
			--prefix=$(PKGSRC_HOST_DIR) \
	)

endef

define PKGSRC_INSTALL_MK_CONF
	$(INSTALL) -D -m 0644 $(TOPDIR)/pkgsrc/mk.conf.tmpl $(PKGSRC_HOST_DIR)/etc/mk.conf
endef

define PKGSRC_SET_CROSS_COMPILE_ROOT
	$(INSTALL) -D -m 0644 $(HOST_DIR)/usr/$(REAL_GNU_TARGET_NAME)/sysroot/usr/include/linux/stddef.h \
		$(PKGSRC_DEST_DIR)/usr/include/stddef.h
endef

HOST_PKGSRC_POST_BUILD_HOOKS += PKGSRC_INSTALL_MK_CONF PKGSRC_SET_CROSS_COMPILE_ROOT

define HOST_PKGSRC_CLEAN_CMDS
	rm -rf $(PKGSRC_SOURCE_DIR)/bootstrap/work
	rm -rf $(PKGSRC_HOST_DIR)/
endef

$(eval $(call GENTARGETS,host))
