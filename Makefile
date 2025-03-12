# Copyright (C) 2021 Lenyu

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for AutoBuild Firmware/Romupdate.sh
LUCI_DEPENDS:=+curl +wget +bash
LUCI_PKGARCH:=all
PKG_VERSION:=2
PKG_RELEASE:=20250312

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
