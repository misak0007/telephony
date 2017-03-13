#
# Copyright (C) 2017-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=codec2
PKG_VERSION:=0.6
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://files.freedv.org/codec2/
PKG_MD5SUM:=789a1c2dacf146ab3efa7ae8c79bba62

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
CMAKE_BINARY_SUBDIR:=build

PKG_MAINTAINER:=Michael Gruz <michael.gruz@gmail.com>

PKG_INSTALL:=1
CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libcodec2
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Codec2 runtime library
  DEPENDS:=+libc
endef

define Package/libcodec2/description
 Codec2 runtime library
 Next-Generation Digital Voice for Two-Way Radio
 .
 Codec2 is an audio codec especially designed for compressing voice at
 very low bit-rates for applications such as digital voice radio.
 .
 This package contains the codec2 runtime library.
endef


CMAKE_OPTIONS += \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_INSTALL_LIBDIR:PATH=lib

define Build/Compile
	cd $(CMAKE_BINARY_DIR);make codec2
endef

define Package/libcodec2/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcodec2.so* $(1)/usr/lib/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/{lib,include}
	$(INSTALL_DIR) $(1)/usr/include/codec2
	$(CP) $(PKG_INSTALL_DIR)/usr/include/codec2/* $(1)/usr/include/codec2/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcodec2.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/codec2.pc $(1)/usr/lib/pkgconfig/
endef

$(eval $(call BuildPackage,libcodec2))
