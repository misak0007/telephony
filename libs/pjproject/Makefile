#
# Copyright (C) 2016 OpenWrt.org
# Copyright (C) 2016 Cesnet, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pjproject
PKG_VERSION:=2.5.5
PKG_RELEASE:=1

PKG_SOURCE:=pjproject-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.pjsip.org/release/$(PKG_VERSION)/
PKG_MD5SUM:=183f7144b9aa238884243c0fc52ece36
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=0
PKG_FIXUP:=libtool

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Michael Gruz <michael.gruz@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/pjproject/Default
  SECTION:=lib
  CATEGORY:=Libraries
  SUBMENU:=Telephony
  URL:=http://www.pjsip.org/
  DEPENDS:=+libuuid +libstdcpp +libpthread +libopenssl +libsrtp
endef

define Package/pjproject/install/lib
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(2).so* $(1)/usr/lib/
endef

define Package/pjsua
  TITLE:=pjsua command line SIP user agent (softphone)
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpj +libpjlib-util +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua \
	 +libpjsip +libpjsua +libresample +libsrtp +libstdcpp +libuuid
endef

define Package/pjsua/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/pjsip-apps/bin/pjsua $(1)/usr/bin/
endef

define PJSIPpackage
  define Package/$(1)
  $$(call Package/pjproject/Default)
    TITLE:=$(1) library
    DEPENDS+=$(3)
  endef

  define Package/$(1)/install
$(call Package/pjproject/install/lib,$$(1),$2)
  endef

  $$(eval $$(call BuildPackage,$(1)))
endef

CONFIGURE_ARGS += \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) \
	--prefix=/usr \
	--bindir=/usr/bin \
	--libdir=/usr/lib \
	--sysconfdir=/etc \
	--disable-floating-point \
	--enable-shared \
	--disable-sound \
	--disable-video \
	--disable-small-filter \
	--disable-large-filter \
	--disable-speex-aec \
	--disable-g711-codec \
	--disable-l16-codec \
	--disable-gsm-codec \
	--disable-g722-codec \
	--disable-g7221-codec \
	--disable-speex-codec \
	--disable-ilbc-codec \
	--disable-sdl \
	--disable-ffmpeg \
	--disable-v4l2 \
	--disable-openh264 \
	--disable-opencore-amr \
	--disable-silk \
	--disable-opus \
	--disable-libyuv \
	--disable-libwebrtc \
	--with-ssl=$(STAGING_DIR)/usr \
	--with-external-srtp=$(STAGING_DIR)/usr

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) ./files/util_remove.sh $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR);chmod a+x util_remove.sh
	cd $(PKG_BUILD_DIR);./util_remove.sh
	echo "#define PJ_HAS_IPV6 1" >> "$(PKG_BUILD_DIR)/pjlib/include/pj/config_site.h"
endef

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) dep
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) all
endef

PJPROJECT_LIBS = \
	libpj libpjlib-util libpjmedia-audiodev libpjmedia-codec \
	libpjmedia-videodev libpjmedia libpjnath libpjsip-simple \
	libpjsip-ua libpjsip libpjsua libpjsua2 libresample

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/{include,lib}
	
	$(CP) -R $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/

	$(foreach m,$(PJPROJECT_LIBS),$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(m)* $(1)/usr/lib/;)
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libpjproject.pc $(1)/usr/lib/pkgconfig/
endef

$(eval $(call PJSIPpackage,libpj,libpj,+librt +libstdcpp +libuuid +libopenssl +libpthread))
$(eval $(call PJSIPpackage,libpjlib-util,libpjlib-util,+libpj))
$(eval $(call PJSIPpackage,libpjmedia,libpjmedia*,+libpj +libpjlib-util +libpjnath +libresample +libsrtp))
$(eval $(call PJSIPpackage,libpjnath,libpjnath,+libpj +libpjlib-util))
$(eval $(call PJSIPpackage,libpjsip-simple,libpjsip-simple,+libpj +libpjlib-util +libpjsip +libsrtp))
$(eval $(call PJSIPpackage,libpjsip-ua,libpjsip-ua,+libpj +libpjlib-util +libpjmedia +libpjsip-simple +libpjsip))
$(eval $(call PJSIPpackage,libpjsip,libpjsip,+libpj +libpjlib-util +libresample +libsrtp))
$(eval $(call PJSIPpackage,libpjsua,libpjsua,+libpj +libpjlib-util +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsip +libsrtp +libstdcpp +libuuid))
$(eval $(call PJSIPpackage,libpjsua2,libpjsua2,+libpj +libpjlib-util +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsip +libpjsua +libsrtp +libstdcpp +libuuid))
$(eval $(call PJSIPpackage,libresample,libresample,+libstdcpp))
$(eval $(call BuildPackage,pjsua))
