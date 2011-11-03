#
# NetBSD package collection (pkgsrc)
# Target packages build support
# 

PKGSRC_BMAKE := $(PKGSRC_HOST_DIR)/bin/bmake
PKGSRC_BMAKE_OPTS := PKGSRC_HOST_DIR="$(PKGSRC_HOST_DIR)" \
		    GNU_TARGET_NAME="$(REAL_GNU_TARGET_NAME)" \
		    PKGSRC_DEST_DIR="$(PKGSRC_DEST_DIR)" \
		    HOST_DIR="$(HOST_DIR)" \
		    DL_DIR="$(TOPDIR)/dl" \
		    ARCH="$(BR2_ARCH)" \
		    PKG_VERBOSE=1 \
		    CC="$(TARGET_CC)" \
		    AR="$(TARGET_AR)" \
		    RANLIB="$(TARGET_RANLIB)" \
		    CFLAGS="$(TARGET_CFLAGS)" \
		    LDFLAGS="$(TARGET_LDFLAGS)"
#		    PKG_DEBUG_LEVEL=2 

PKGSRC_TEST_TARGET="lang/ruby"

pkgsrc-test: 
	$(INSTALL) -D -m 0644 $(HOST_DIR)/usr/$(REAL_GNU_TARGET_NAME)/sysroot/usr/include/linux/stddef.h \
		$(PKGSRC_DEST_DIR)/usr/include/stddef.h
	$(PKGSRC_BMAKE) $(PKGSRC_BMAKE_OPTS) \
		-C $(PKGSRC_SOURCE_DIR)/$(PKGSRC_TEST_TARGET) \
		install

