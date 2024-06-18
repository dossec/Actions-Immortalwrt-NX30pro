#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default


rm -rf feeds/packages/lang/golang
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/small/luci-app-mosdns
rm -rf feeds/small/mosdns
rm -rf feeds/kenzo/luci-app-adguardhome
rm -rf feeds/kenzo/adguardhome
rm -rf feeds/small/v2ray-geodata
rm -rf feeds/luci/applications/luci-app-openclash
cp -R feeds/kenzo/luci-app-openclash feeds/luci/applications/
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
