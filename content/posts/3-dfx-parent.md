+++
title = "dfx 使用指南"
date = "2020-06-12"
description = "dfx , 是开发人员在 IC 网络上，创建、部署和管理 dapps 的主要工具。"

[taxonomies]
tags = ["DFX"]
+++

# dfx

`dfx` 命令行工具 , 是开发人员在 IC 网络上，创建、部署和管理 dapps 的主要工具。

## 基本用法

``` bash
dfx [option] [subcommand] [flag]
```

## Flags

|       Flag        |          描述          |
| :---------------: | :--------------------: |
|  `-h`, `--help`   |      显示使用信息      |
|  `-q`, `--quiet`  |      取消显示信息      |
| `-v`, `--verbose` | 显示有关操作的详细信息 |
| `-V`, `--version` |      显示版本信息      |

## Options

| Option                   | 描述                                                                                      |
| ------------------------ | ----------------------------------------------------------------------------------------- |
| `-- identity <identity>` | 指定运行命令时使用的用户「身份」                                                          |
| `--logfile <logfile>`    | 如果指定了 `--logfile` , 则将日志消息写入指定的日志文名                                   |
| `--log <logmode>`        | 指定要使用的日志记录模式， 支持 `stderr`、`file`、`tee`(stderr+file)、 默认 `stderr` 模式 |

## Subcommands

| Command                                 | 描述                                                                                                |
| --------------------------------------- | --------------------------------------------------------------------------------------------------- |
| [`bootstrap`](dfx-bootstrap/index.html) | Bootstrap Web Server 为你的项目提供前端罐                                                           |
| [`build`](dfx-build/index.html)         | 将程序编译成可部署在 IC 上的 WebAssembly 模块                                                       |
| [`cache`](dfx-cache/index.html)         | 管理本地计算机上的 dfx 缓存                                                                         |
| [`canister`](dfx-canister/index.html)   | 管理已部署的罐                                                                                      |
| [`deploy`](dfx-deploy/index.html)       | 部署工程下的罐，默认部署所有罐                                                                      |
| [`identity`](dfx-identity/index.html)   | 使您能够创建和管理用于与 IC 通信的身份                                                              |
| [`ledger`](dfx-ledger/index.html)       | 使您能够与运行在 Internet 计算机上的分类帐罐中的帐户进行交互。                                      |
| [`dfx wallet`](dfx-wallet/index.html)   | 使您能够管理与当前选定「身份」关联的默认 cycles 钱包的 cycles、controllers、custodians 和 addresses |

## Examples

显示有关当前安装的 dfx 版本的信息，可以运行以下命令：

``` bash
dfx --version
```

若要查看特定 subcommand 的使用信息，请指定 subcommand 和 --help 标志
``` bash
dfx build --help
```

### Using logging options

您可以使用 `--verbose` 和 `--quiet` 标志，来递增或递减日志记录级别。

默认日志级别会显示 CRITICAL, ERROR, WARNING, and INFO 这四类消息，如果指定 `-v`会增加 DEBUG 级别日志，`-vv`会增加 TRACE 级别日志

添加 `--quiet` 标志，会降低日志记录级别。例如，若要删除所有日志，可以运行类似于下面的命令：

``` bash
dfx -qqqq build
```
请记住，使用 TRACE 级别的日志记录 (-vv) 会生成许多可能影响性能的日志消息，只有在需要进行故障排除或分析时才应该使用这些消息。

要将日志消息输出到名为 newlog.txt 的文件中，并在创建新项目时在终端上显示这些消息，可以运行类似于下面的命令：

``` bash
dfx --log tee --logfile newlog.txt new hello_world
```

### Specifying a user identity

例如，您可能希望通过运行以下命令来测试 `devops` 用户是否可以调用 `accounts` 罐的 `edit_profile` 函数：

    dfx --identity devops canister call accounts modify_profile '("Kris Smith")'
