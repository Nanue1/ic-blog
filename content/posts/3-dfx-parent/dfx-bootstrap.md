+++
title = "dfx 使用指南 - bootstrap"
date = "2020-06-01"

[taxonomies]
tags = ["DFX"]
+++

# dfx bootstrap 

使用 dfx bootstrap 命令启动 bootstrap Web Server，在 dfx.json 文件中定义或使用命令行选项指定的 Server 配置信息 。

bootstrap Web Server 为你的项目提供前端。

## 基本用法

``` bash
dfx bootstrap [option]
```

## Flags 

可以在 `dfx bootstrap` 命令中使用下列可选 flag

| Flag              | Description    |
| ----------------- | -------------- |
| `-h`, `--help`    | 显示使用信息。 |
| `-V`, `--version` | 显示版本信息。 |

## Options 

您可以为 `dfx bootstrap` 命令指定以下 options

| Option                | Description|
| --------------------- | -----------|
| --ip <ip_address>    | 指定引导服务器侦听的 IP 地址。如果不指定 IP 地址，则使用在 dfx.json 配置文件中配置的地址设置。默认情况下，服务器地址是 127.0.0.1。 |
|--network <network> | 指定连接的网络，默认本本地网络地址为`http://127.0.0.1:8080/api`|
| --port <port>       | 指定服务监听端口，默认 8081|
| --root <root>       | 为 bootstrap server 指定静态资源目录。默认路径：`$HOME/.cache/dfinity/versions/$DFX_VERSION/js-user-library/dist/bootstrap`.                                 |
| --timeout <timeout> | 指定 bootstrap server 等待上行请求完成的最长时间（以秒为单位）。默认 30 秒。|

## Examples 

可以使用 `dfx bootstrap` 命令为应用程序启动 Web 服务器，使用自定义设置，包括特定的服务器地址、端口号和静态资产位置。

例如，要使用特定的 IP 地址和端口号启动 bootstrap server，可以运行类似于下面的命令：

``` bash
dfx bootstrap --ip 192.168.47.1 --port 5353
```

该命令显示类似于下面的输出：

``` bash
binding to: V4(192.168.47.1:5353)
replica(s): http://127.0.0.1:8080/api
Webserver started...
```
若要使用默认服务器地址和端口号，但要为静态资产指定自定义位置和更长的超时时间，可以运行类似于下面的命令：

``` bash
dfx bootstrap --root $HOME/ic-projects/assets --timeout 60
```
可以使用 CTRL-C 停止 bootstrap server