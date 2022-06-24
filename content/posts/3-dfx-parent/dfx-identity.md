+++
title = "dfx 使用指南 - identity"
date = "2020-06-01"

[taxonomies]
tags = ["DFX"]
+++
# dfx identity

使用 `dfx Identity` 命令来管理用户身份

``` bash
dfx identity [subcommand] [flag]
```

查看子命令帮助信息

``` bash
dfx identity new --help
```

| Command         | Description                        |
| --------------- | ---------------------------------- |
| `get-principal` | 显示当前身份关联的主体信息         |
| `get-wallet`    | 显示当前身份主体关联的钱包容器标识 |
| `import`        | 通过导入 PEM 证书文件创建新的身份  |
| `list`          | 列出存在的身份                     |
| `new`           | 创建新的用户身份                   |
| `remove`        | 删除存在的身份                     |
| `rename`        | 重命名身份                         |
| `set-wallet`    | 为当前身份主体设置钱包容器         |
| `use`]          | 指定当前使用的身份                 |
| `whoami`        | 显示当前使用的身份                 |

## Creating a default identity

第一次运行`dfx canister create`命令会生成一个 `default` 身份，公私钥文件会生成保存到 `$HOME/.config/dfx/identity/default/identity.pem`

可以使用  `dfx identity new`  创建新身份，并把证书文件存放到 `$HOME/.config/dfx/identity/<identity_name>/identity.pem` 文件内

    dfx identity new ic_admin

## dfx identity get-principal
显示当前身份关联的主体信息
## dfx identity get-wallet
显示当前身份主体关联的钱包容器标识|
## dfx identity import

通过导入 PEM 证书文件，使用 `dfx identity import` 命令创建一个新的用户身份

### Basic usage

``` bash
dfx identity import [options] identity-name pem_file-name
```

### Options

| Argument               | Description                                                                                                   |
| ---------------------- | ------------------------------------------------------------------------------------------------------------- |
| `--disable-encryption` | 危险操作⚠️: 默认情况下，PEM 文件写入磁盘是通过密码加密的，你可以使用这个选项关闭加密操作，不需要每次都输入密码 |
| `--force`              | 如果身份已经存在，删除并重建                                                                                  |

### Examples

``` bash
dfx identity import alice generated-id.pem
```
执行命令后，将 `generated-id.pem` 文件添加到  `~/.config/dfx/identity/alice` 目录下

## dfx identity list
列出存在的用户身份
## dfx identity new

使用  `dfx identity new` 添加新的身份信息

### Basic usage

``` bash
dfx identity new [options] _identity-name_
```

### Arguments

| Argument          | Description  |
| ----------------- | ------------ |
| `<identity_name>` | 指定身份名称 |

### Options

| Argument                                      | Description                                                                                                                                             |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--disable-encryption`                        | 危险：默认情况下，将 PEM 文件写入磁盘时使用密码进行加密。如果你想方便的不必输入你的密码（但是冒着你的 PEM 文件泄露的风险） ，你可以用这个标志禁用加密。 |
| `--force`                                     | 如果身份已经存在，删除并重建                                                                                                                            |
| `--hsm-key-id <hsm key id>`                   | 十六进制数字对的序列                                                                                                                                    |
| `--hsm-pkcs11-lib-path <hsm pkcs11 lib path>` | 指定 opensc-pkcs11 库路径地址 如： "/usr/local/lib/opensc-pkcs11.so"                                                                                    |

## dfx identity remove

    dfx identity remove default

删除 `default` 身份时，必须保证有一个身份可用。如果被删除的身份配置了钱包，你需要使用 `--drop-wallets` 参数，才能删除掉当前身份，这样做是为了避免当前身份丢失钱包的控制权。

## dfx identity rename

    dfx identity rename test_admin devops

## dfx identity set-wallet

使用 `dfx identity set-wallet` 命令为当前身份指定钱包容器

### Basic usage

``` bash
dfx identity set-wallet [flag] [--canister-name canister-name]
```

### Flags

You can use the following optional flags with the `dfx identity set-wallet` command.

| Flag    | Description                                                |
| ------- | ---------------------------------------------------------- |
| `force` | 跳过验证您指定的罐是否为有效的钱包罐，只作用于本地网络环境 |

### Example

    export WALLET_CANISTER_ID=$(dfx identity get-wallet)
    dfx identity --network=https://192.168.74.4 set-wallet --canister-name ${WALLET_CANISTER_ID}
