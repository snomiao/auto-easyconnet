# Auto EasyConnect

本项目将 EasyConnect VPN 转换为一个长期在线的 socks5 代理以方便个人使用。

## 注意事项

> **安全声明：** 本程序仅仅是避免了手动连接vpn的麻烦，部署过程中使用的vpn账号密码，以及内网穿透等功能，都**没有**做特别的安全防护，所以请配置足够强度的密码，并在部署完成后不要公开地址和端口，以免造成安全隐患，自己使用就可以了。

## SIT-VPN-SERVICE 服务架构简介及部署教程

```
组件 1 ，运行： EasyConnectVPN + frpc 内网穿透客户端（不要求公网）
组件 2 ，运行：frps 服务器（要求有公网）
组件 1 需要运行在 Windows 上
组件 1 和 2 可以运行在同一台电脑上。
```

### 第一部分，配置自动连接VPN

安装 EasyConnect，启动后，填写你自己的帐号，选择记住密码，连接登录 VPN，

启动 `./vpn/EasyAutoConnect.exe`，然后关闭 VPN ，测试VPN自动重启并登录，即可。

### 第二部分，配置 frp 将 VPN 转为 socks5 代理。

在组件 1 中，复制 [frpc_demo.ini]( ./frpc/frpc_demo.ini) 并改名为 `frpc.ini`

具体配置教程请参考：
- [fatedier/frp: A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet.]( https://github.com/fatedier/frp )

./frpc/frpc.ini
```ini
# frpc 用来把本地网络做内网穿透代理出去
# 于是你就可以在公网上访问到本地搭建的VPN
; 

[common]
token = ##############################
server_addr = ##############################
server_port = 1040
tls_enable = true

# 本地管理web界面，建议只在本机开启。
admin_addr = 127.0.0.1
admin_port = 7400
admin_user = admin
admin_pwd  = admin

# 日志，排错用，一般不用管
log_file = ./frpc.log
log_level = info
log_max_days = 3

[sno-vpn-##############################]
type = tcp
sk = ##############################
remote_port = 1081
group = sno
group_key = ##############################
plugin = socks5
plugin_user = ##############################
plugin_passwd = ##############################

use_encryption = true
use_compression = true
health_check_type = tcp
health_check_timeout_s = 3
health_check_max_failed = 3
health_check_interval_s = 10
```

然后在组件 2 中按如上方法继续配置 frps 即可。

## 协议

本项目使用 [Apache License, Version 2.0]( https://www.apache.org/licenses/LICENSE-2.0 )
> 解释请见：[如何理解Apache License, Version 2.0（整理） - 范仁义 - 博客园]( https://www.cnblogs.com/Renyi-Fan/p/8148658.html )


## 有任何疑问？

请在 issues 提出。

