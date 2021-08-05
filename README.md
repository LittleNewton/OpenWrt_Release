# **OpenWRT x86** Release

## 1. 说明

依据官方 OpenWRT 代码库编译，添加了若干官方库不提供但经常需要用到的插件。

官方库链接：

```
https://github.com/openwrt/openwrt
```

本库仅为提供二进制镜像，因此除介绍文件，不再提供任何源代码。因为并没有对源代码进行任何修改。

## 2. 官方库中选中的插件、kmod

参见 `build-info` 文件夹。

- 支持 Mellanox 最新版网卡，`mellanox-core 4` 和 `mellanox-core-5` 驱动都已经集成。
- MWAN3
- QoS
- TTYD Terminal 网页版终端
- netdata: 若无法通过 your-ip-addr:19999 端口打开，则可通过 opkg 卸载并重装 netdata，重启之后就能正常使用 netdata 了。

```
// 关于 netdata

opkg remove netdata
opkg update
opkg install netdata
```

## 3. 官方之外的插件

### 3.1 Passwall

**代理、分流工具。** 

```
// passwall 官方 GitHub 仓库链接：

https://github.com/xiaorouji/openwrt-passwall

选中的功能：

CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Brook=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ChinaDNS_NG=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Kcptun=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_NaiveProxy=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_Libev_Server=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Client=y
CONFIG_PACKAGE_luci-i18n-passwall-zh-cn=y
```

> **Note**: 因为 Trojan-Go 的编译比较复杂，而且官方库的 Golang 版本和 Trojan-Go 的版本要求有点区别，因此并未集成 Trojan-Go，若实在有需要，**可点击手动更新按钮，Passwall 会自动下载最新版 Trojan-Go 并自动安装。** 如下图所示 Manually update.

![](img/trojan-Go.jpg)

### 3.2 尚未集成的第三方插件

- 阿里云、腾讯云 DDNS：目前官方的 DDNS 插件不支持这两家 DDNS 服务商，因此需要修改官方 ddns 插件。
- Open-Clash

## 4. 免责声明

与本库相关的所有代码均可在 GitHub 找到并自行编译，这里只是分享一个我个人比较喜欢的取舍结果。**请勿用与本库相关的任何东西从事违法活动。**
