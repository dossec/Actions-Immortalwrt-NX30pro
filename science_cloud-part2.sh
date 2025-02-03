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

# Modify wifi name
cat > package/base-files/files/etc/uci-defaults/99-set-wifi.sh <<EOF
#uci set network.lan.ipaddr='192.168.6.1'
#uci commit network
for radio in \$(uci show wireless | grep '=wifi-device' | cut -d'.' -f2 | cut -d'=' -f1);do
    uci set wireless.\$radio.disabled='0'
    #uci set wireless.default_\$radio.ssid='OpenWrt'
    #uci set wireless.default_radio1.ssid='OpenWrt-5G'
    uci set wireless.default_\$radio.encryption='psk-mixed'
    uci set wireless.default_\$radio.key='1234567890'
done
uci commit wireless
wifi reload
exit 0
EOF
 
# 修改默认主机名
#sed -i '/uci commit system/i\uci set system.@system[0].hostname='Soft_Router'' package/lean/default-settings/files/zzz-default-settings
 
# 加入编译者信息
#sed -i "s/OpenWrt /Kinoko build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
 



# drop mosdns and v2ray-geodata packages that come with the source 删除源代码附带的 modns 和 v2ray-Geodata 包
#find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
#find ./ | grep Makefile | grep mosdns | xargs rm -f
# Add a mosdns 添加mosdns
#git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
#git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
#make package/mosdns/luci-app-mosdns/compile V=s
