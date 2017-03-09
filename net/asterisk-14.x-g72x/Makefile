#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk14-codec-g729
PKG_VERSION:=1.4
PKG_RELEASE:=1

PKG_SOURCE:=asterisk-g72x-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://asterisk.hosting.lv/src/
PKG_MD5SUM:=4573a6949cf46dadaf1d0d6bc2ee6755

PKG_BUILD_DIR=$(BUILD_DIR)/asterisk14-g72x-$(PKG_VERSION)
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=README.md
PKG_MAINTAINER:=Michael Gruz <michael.gruz@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/asterisk14-codec-g729
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=G.729 codec for Asterisk open source PBX
  URL:=http://asterisk.hosting.lv
  DEPENDS:= +bcg729 asterisk14
endef

define Package/asterisk14-codec-g729/description
 Asterisk G.729 codec based on bcg729 implementation.
endef

MAKE_ARGS:= \
	CC="$(TARGET_CC)" \
	LD="$(TARGET_LD)" \
	CFLAGS="$(TARGET_CFLAGS) -DASTERISK_VERSION_NUM=130000 -DLOW_MEMORY -D_XOPEN_SOURCE=600 $(TARGET_CPPFLAGS) -I$(STAGING_DIR)/usr/include/asterisk-14/include -DHAVE_CONFIG_H -I. -fPIC" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	DESTDIR="$(PKG_INSTALL_DIR)"

CONFIGURE_ARGS+=\
	--with-asterisk-includes=$(STAGING_DIR)/usr/include/asterisk-14/include \
	--with-asterisk140 \
	--with-bcg729 \
	--enable-shared \
	$(MAKE_ARGS)

define Package/asterisk14-codec-g729/Install
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/asterisk/modules/codec_g729.so $(1)/usr/lib/asterisk/modules/
endef

$(eval $(call BuildPackage,asterisk14-codec-g729))

