#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=iksemel
PKG_VERSION:=1.5
PKG_RELEASE:=1
PKG_REV:=978b733462e41efd5db72bc9974cb3b0d1d5f6fa

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/meduketto/iksemel
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=0
PKG_FIXUP:=libtool

PKG_LICENSE:=LGPL-2.1
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Michael Gruz <michael.gruz@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/libiksemel
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=C library for the Jabber IM platform
  URL:=https://github.com/meduketto/iksemel
  DEPENDS:= +libopenssl
endef

define Package/libiksemel/description
Iksemel is an XML parser library mainly designed for Jabber applications.
It provides SAX, DOM, and special Jabber stream APIs. Library is coded
in ANSI C except the network code (which is POSIX compatible), thus
highly portable.
endef

define Package/libiksemel-utils
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=utilities from the iksemel library
  DEPENDS:= +libiksemel
endef

define Package/libiksemel-utils/description
This package includes three utilitaries from the library: ikslint,
which checks xml files for well-formedness, iksperf, which tests
speed and memory usage, and, finally, iksroster, which backups your
roster.
endef

CONFIGURE_ARGS += \
		--without-gnutls \
		--disable-python

define Package/libiksemel/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libiksemel.so* $(1)/usr/lib/
endef

define Package/libiksemel-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/{include,lib}
	$(CP) -R $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libiksemel.{a,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/iksemel.pc $(1)/usr/lib/pkgconfig/
endef

$(eval $(call BuildPackage,libiksemel))
$(eval $(call BuildPackage,libiksemel-utils))
