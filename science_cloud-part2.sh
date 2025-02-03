#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 修改默认IP192.168.1.1为后边那个ip
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# 修改默认主题
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

 
# 修改默认主机名
#sed -i '/uci commit system/i\uci set system.@system[0].hostname='Soft_Router'' package/lean/default-settings/files/zzz-default-settings
 
# 加入编译者信息
#sed -i "s/OpenWrt /Kinoko build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# drop mosdns and v2ray-geodata packages that come with the source

# Modify wifi name
cat > package/base-files/files/etc/uci-defaults/99-set-wifi.sh <<EOF
#uci set network.lan.ipaddr='192.168.6.1'
#uci commit network
for radio in \$(uci show wireless | grep '=wifi-device' | cut -d'.' -f2 | cut -d'=' -f1);do
    uci set wireless.default_\$radio.encryption='psk-mixed'
    uci set wireless.default_\$radio.key='1234567890'
done
uci commit wireless
wifi reload
exit 0
EOF
