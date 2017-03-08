#
# Copyright (C) 2014 OpenWrt.org
# Copyright (C) 2011 Victor Seva <linuxmaniac@torreviejawireless.org>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libsrtp
PKG_VERSION:=1.5.4
PKG_RELEASE:=1

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/cisco/libsrtp/archive
PKG_MD5SUM:=64a9580f86a9c3e1c4986e944e6a5a84

PKG_BUILD_DIR:=$(BUILD_DIR)/libsrtp-$(PKG_VERSION)
PKG_INSTALL:=1

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Michael Gruz <michael.gruz@gmail.com>

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS += \
		--disable-debug \
		--enable-syslog \
		--enable-openssl \
		--with-openssl-dir=$(STAGING_DIR)/usr

define Package/libsrtp
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Secure Real-time Transport Protocol (SRTP) library
  URL:=https://github.com/cisco/libsrtp
  DEPENDS:=+libpcap +libopenssl +zlib
endef

define Package/libsrtp/description
Open-source implementation of the Secure Real-time Transport
Protocol (SRTP) originally authored by Cisco Systems, Inc.
It is available under a BSD-style license.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	cd $(PKG_BUILD_DIR);sed -i -e "s:/usr/share/dict/words:rtpw.c:" test/rtpw.c
endef

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) libsrtp.a shared_library
endef

define Build/Install
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR=$(PKG_INSTALL_DIR) uninstall
	$(call Build/Install/Default)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/srtp $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsrtp.{a,so*} $(1)/usr/lib/
endef


define Package/libsrtp/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsrtp.so.* \
		$(1)/usr/lib/
endef

$(eval $(call BuildPackage,libsrtp))
