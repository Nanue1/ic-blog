+++
title = "dfx 使用指南 - canister"
date = "2020-06-01"

[taxonomies]
tags = ["DFX"]

+++
# dfx canister

使用带有 flags 和 subcommands 的 `dfx canister` 命令来管理 canister 操作。在大多数情况下，在编译程序后，可以使用 dfx canister 子命令去管理容器的生命周期和执行关键任务（如调用程序函数）。

运行 dfx canister 命令的基本语法是：

``` bash
dfx canister [subcommand] [flag]
```

| Command           | Description                                                                                                                                                                       |
| ----------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `call`            | 调用指定的方法                                                                                                                                                                    |
| `create`          | 通过在执行环境中注册容器 identifier，创建一个新的“empty”容器。                                                                                                                    |
| `delete`          | 删除已经停止的罐                                                                                                                                                                  |
| `deposit-cycles`  | 将 cycles 存入到指定的罐中                                                                                                                                                        |
| `id`              | 显示罐的 identifier                                                                                                                                                               |
| `info`            | 以认证的方式获得一个容器的 WASM 模块及其当前 controller 的 hash。                                                                                                                 |
| `install`         | 将编译后的代码作为罐安装。                                                                                                                                                        |
| `request-status`  | 请求对容器调用的状态                                                                                                                                                              |
| `sign`            | 在调用指定的罐标识符之前，创建一个已签名的 message.json 文件。例如，如果希望发送调用网络神经系统 (NNS) 治理罐来管理神经元的消息，出于安全原因，可能需要将消息签名与消息传递分开。 |
| `send`            | 将先前签名过的 message.json 发送到指定的罐 identifier 。例如，如果希望发送调用网络神经系统 (NNS) 治理罐来管理神经元的消息，出于安全原因，可能需要将消息签名与消息传递分开。       |
| `start`           | 重启已经停止的罐                                                                                                                                                                  |
| `status`          | 请求罐的运行状态                                                                                                                                                                  |
| `stop`            | 停止正在运行的罐                                                                                                                                                                  |
| `uninstall-code`  | 卸载罐，删除其代码和状态，在 Internet 计算机网络上                                                                                                                                |
| `update-settings` | 更新一个或多个存储器的设置（比如它的控制器、计算分配或内存分配）                                                                                                                  |

## 修改默认部署环境 
----

默认情况下，`dfx canister` 命令作用在 dfx.json 文件中指定 canister 执行环境。如果希望在不更改 dfx.json 配置文件中的设置的情况下，将 dfx canister 子命令发送到 testnet，可以使用`--network` 选项显式指定要连接到的 URL。

例如，要在本地罐执行环境中为项目注册唯一的罐标识符，可以运行以下命令：

``` bash
dfx canister create --all
```

如果要在 ic 网络上注册唯一的罐标识符，可以运行以下命令：

``` bash
dfx canister --network ic create --all
```
SDK 带有 `ic` 的别名，该别名被配置为指向主网环境。您还可以将 URL 作为网络选项传递，或在 dfx.json 中配置其他别名。

为了说明这一点，您可以使用类似于下面的命令来调用运行在 testnet 上的容器和函数：

``` bash
dfx canister --network http://192.168.3.1:5678 call counter get
```

注意，您必须在罐操作（`create`或`call`）之前指定 `--network` 参数，如罐名 (counter) 和函数 (`get`)。

## dfx canister call 
---- 
使用 `dfx canister call` 调用已部署罐上的指定方法。

### Basic usage

``` bash
dfx canister call [option] canister_name method_name [argument] [flag]
```

### Flags

| Flag              | Description                                                          |
| ----------------- | -------------------------------------------------------------------- |
| `--async`         | 让轮询请求无需等待，异步请求罐                                       |
| `-h`, `--help`    | 显示使用信息                                                         |
| `--query`         | 允许您向已部署的罐发送查询请求                                       |
| `--update`        | 允许您向已部署的罐发送更新请求，默认情况下，罐调用使用 update 方法。 |
| `-V`, `--version` | 显示版本信息                                                         |

### Options

| Option              | Description                                                       |
| ------------------- | ----------------------------------------------------------------- |
| `--output <output>` | 显示方法返回结果时，指定使用的输出格式。有效值为 `idl` 和 `raw`。 |
| `--type <type>`     | 进行调用时指定参数的数据格式。有效值是 `idl` 和 `raw`。           |

### Arguments

| Argument        | Description                                                                                                                                                                                                                                                                                                                                                                               |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `canister_name` | 指定要调用的罐的名称。Canister name 是一个必需的参数，它应该与 dfx.json 配置文件的 canister 部分中为项目配置的罐名称相匹配。                                                                                                                                                                                                                                                              |
| `method_name`   | 指定要在罐子上调用的方法名。罐子方法是必需的参                                                                                                                                                                                                                                                                                                                                            |
| `argument`      | 指定要传递给方法的参数。根据您的程序逻辑，参数可以是必需的或可选的参数。如果将参数传递给容器，则可以使用`--type` 选项指定数据格式类型。默认情况下，可以使用 `Candid` (idl) 语法为数据值指定参数。有关使用 Candid 及其支持的类型的信息，请参见 [支持的类型](https://internetcomputer.org/docs/current/references/candid-ref/)。如果希望将原始字节传递给容器，可以使用 `raw` 作为参数类型。 |

### Examples

在使用 `dfx canister install` 命令部署完容器之后，可以使用 `dfx canister call` 命令调用特定的方法。例如，get 方法，返回一个 Request ID 可以运行以下命令：

``` bash
dfx canister call counter get --async
```

在这个示例中，命令包含了 --async 选项，以指示您希望进行单独的请求状态调用，而不是等待轮询本地罐执行环境以获得结果。当处理一个操作可能需要一些时间才能完成时，--async 选项非常有用。该选项允许您继续执行其他操作，然后使用单独的`dfx canister request-status` 命令检查结果。返回的结果将显示为 IDL 文本格式

#### Using the IDL syntax

你可以为 Text 类型的数据，使用以下命令，指定使用 IDL 语法传递参数

``` bash
dfx canister call hello greet --type idl '("Lisa")'
("Hello, Lisa!")

dfx canister call hello greet '("Lisa")' --type idl
("Hello, Lisa!")
```

您还可以通过运行类似于下面的命令隐式地使用 IDL:

``` bash
dfx canister call hello greet '("Lisa")'
("Hello, Lisa!")
```

若要使用 IDL 语法指定多个参数，请在参数之间使用逗号：

``` bash
dfx canister call contacts insert '("Amy Lu","01 916-335-2042")'

dfx canister call hotel guestroom '("Deluxe Suite",42,true)'
```

通过运行类似于下面的命令，可以以字节为单位传递原始数据：

``` bash
dfx canister call hello greet --type raw '4449444c00017103e29883'
```

此示例使用原始数据类型将一个十六进制传递给 hello 罐的 greet 函数

## dfx canister create
----
使用 `dfx canister create` 命令注册一个或多个 canister 标识符，而不需要编译代码。

注意，只能在项目目录结构中运行此命令。例如，如果项目名称为 hello _ world，则当前工作目录必须是 hello _ world 顶级项目目录或其子目录之一。

第一次运行 dfx canister create 命令来注册标识符时，将使用公钥/私钥对凭据来创建默认用户标识。默认用户的凭据从 $HOME/.dfinity/identity/creds.pem 迁移到 $HOME/.config/dfx/identity/default/identity.pem 。

### Basic usage

``` bash
dfx canister create [option] [flag] [--all | canister_name]
```

### Options

| Option                             | Description                       |
| ---------------------------------- | --------------------------------- |
| `--with-cycles <number-of-cycles>` | 通过钱包创建罐时，指定初始 cycles |

### Arguments

| Argument        | Description                                                      |
| --------------- | ---------------------------------------------------------------- |
| `--all`         | 指定 dfx.json 文件中定义的所有罐， 必须指定 `--all` 或单独的罐名 |
| `canister_name` | 指定 dfx.json 文件中定义的单个罐                                 |

### Examples

您可以使用 dfx canister create 命令来注册 canister 标识符，而无需首先编译任何代码。例如，如果希望在编写程序之前为项目 my_counter 创建罐标识符，可以运行以下命令：

``` bash
dfx canister create my_counter
```

您可以使用 dfx canister create 命令和 --with-cles 选项来指定在项目中创建一个或所有容器时的初始平衡。例如，若要为所有罐指定 8000000000000 周期的初始余额，请运行以下命令：

``` bash
dfx canister create --with-cycles 8000000000000 --all
```

## dfx canister delete
----

使用 `dfx canister delete`命令，删除已停止的容器。

### Basic usage

``` bash
dfx canister delete [flag] [--all | canister_name]
```

### Arguments

| Argument        | Description                                                      |
| --------------- | ---------------------------------------------------------------- |
| `--all`         | 指定 dfx.json 文件中定义的所有罐， 必须指定 `--all` 或单独的罐名 |
| `canister_name` | 指定 dfx.json 文件中定义的单个罐                                 |

### Examples

您可以使用 `dfx canister delete`命令来删除特定的储存器或所有储存器。
``` bash
dfx canister delete hello_world

dfx canister --network=ic delete --all
```

## dfx canister deposit-cycles
----

使用`dfx canister deposit-cycles`命令将配置好的钱包中的 cyles 存放到罐中。

请注意，您必须将您的 cycles 钱包配置为此工作。

### Basic usage

``` bash
dfx canister deposit-cycles [amount of cycles] [--all | canister_name]
```
### Arguments
| Argument        | Description                                                      |
| --------------- | ---------------------------------------------------------------- |
| `--all`         | 指定 dfx.json 文件中定义的所有罐， 必须指定 `--all` 或单独的罐名 |
| `canister_name` | 指定 dfx.json 文件中定义的单个罐                                 |
### Examples

要将 1T 周期添加到名为 hello 的罐中，可以运行以下命令：
``` bash
dfx canister deposit-cycles 1000000000000 hello
```

为 dfx.json 中定义的每一个罐，充值 2T cycles
``` bash
dfx canister deposit-cycles 2000000000000 --all
```

## dfx canister id
----
使用 `dfx canister id` 获取特定罐名的罐标识符
### Basic usage
``` bash
dfx canister id [flag] canister_name
```

### Arguments

| Argument        | Description                      |
| --------------- | -------------------------------- |
| `canister_name` | 指定要为其显示标识符的罐的名称。 |

### Examples

要显示 hello_world 罐的罐标识符，可以运行以下命令：

``` bash
dfx canister id hello_world
```

输出：

``` bash
75hes-oqbaa-aaaaa-aaaaa-aaaaa-aaaaa-aaaaa-q
```

## dfx canister install
----

使用 `dfx canister install` 命令将编译后的代码作为一个 canister 安装

### Basic usage

``` bash
dfx canister install [flag] [option] [--all | canister_name]
```
### Flags

| Flag      | Description |
| --------- | ----------- |
| `--async` | 异步安装    |

### Options

| Option                                            | Description                                                                                                                   |
| ------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `--argument <argument>`                           | 指定在安装过程中传递给容器的参数。                                                                                            |
| `--argument-type <argument-type>`                 | 使用 `--argument` 选项指定安装时参数的数据格式。有效值是 idl 和 raw。默认情况下，可以使用 Candid (idl) 语法为数据值指定参数。 |
| `-c`, `--compute-allocation <compute-allocation>` | 为执行容器设置 CPU , 您可以将此值设置为 0 到 100 之间的百分比                                                                 |
| `--memory-allocation <memory-allocation>`         | 指定容器总共允许使用多少内存。您可以将此值设置为 0 到 8MB 的范围                                                              |
| `-m`, `--mode <mode>`                             | 指定是 install, reinstall, 还是 upgrade 罐                                                                                    |

### Examples

您可以使用 dfx canister install 命令将使用 dfx build 命令编译的 WebAssembly 部署为一个 canister

``` bash
dfx canister install --all
```

``` bash
dfx canister install hello_world
```

``` bash
dfx canister install hello_world --async
```

``` bash
dfx canister --network http://192.168.3.1:5678 install --all
```

#### 分配消息处理

使用 `--compute-allocation` 选项，定义 CPU 50% 的时间用来处理罐的执行任务

``` bash
dfx canister install --all --compute-allocation 50
```

此选项的默认值为 0, 表示 CPU 处理执行任务是按照 round-robin 循环算法方式，在队列中等待处理

## dfx canister request-status
----

使用 `dfx canister request-status` 获取对容器的指定调用的状态

### Basic usage

``` bash
dfx canister request-status request_id
```
### Arguments

| Argument     | Description                                                                                                |
| ------------ | ---------------------------------------------------------------------------------------------------------- |
| `request_id` | 指定 dfx canister call 或 dfx canister install 异步调用返回的标识符 。此标识符是以 0x 开头的十六进制字符串 |

### Examples

``` bash
dfx canister request-status 0x58d08e785445dcab4ff090463b9e8b12565a67bf436251d13e308b32b5058608
```

## dfx canister set-controller

使用 `dfx canister set-controller` 命令指定用户或罐作为特定罐的控制标识。

----

### Basic usage

``` bash
dfx canister set-controller [flag] canister new-controller
```

### Arguments

| Argument           | Description                                            |
| ------------------ | ------------------------------------------------------ |
| `<canister>`       | 为 *new_controller* 参数，指定作用的容器名或容器标识符 |
| `<new_controller>` | 指定控制器的标识名或 principal                         |
 
### Examples

You can use the `dfx canister set-controller` command to specify a user or canister as the controlling identity for a specific canister.

使用 `dfx canister request-status` 命令指定用户或钱包罐作为特定罐的控制标识。

1. 指定用户作为控制器：

``` bash
    dfx canister set-controller hello_world pubsadmin
    dfx canister set-controller hello_world wcp5u-pietp-k5jz4-sdaaz-g3x4l-zjzxa-lxnly-fp2mk-j3j77-25qat-pqe
```

2. 指定钱包罐作为控制器：

```bash
    dfx canister set-controller open_sf_assets r7inp-6aaaa-aaaaa-aaabq-cai
```
现在可以使用钱包罐 r7inp-6aaaa-aaaaaaabq-cai 发送循环或将 custodians 添加到 open_sf_asset 罐

## dfx canister send
----

`dfx canister call` =  `dfx canister sign` + `dfx canister send`, 使用单独的调用可以为事务增加安全性。

例如，在创建 neuron stake 时，您可能希望使用 dfx canister sign 创建一个带签名的 message.json 文件，然后使用 dfx canister send 命令来传递带签名的消息。

### Basic usage

``` bash
dfx canister send file_name
```

### Examples

使用 dfx canister send 命令将使用 dfx canister sign 命令创建的签名消息发送到 genesis token canister (GTC)  ，通过运行以下命令创建一个代表您的神经元：

`dfx canister send message.json`

## dfx canister sign
----

使用 `dfx canister sign` 对消息进行签名

### Basic usage

``` bash
dfx canister sign [flag] [option] canister-name method-name [argument]
```

### Flags

| Flag       | Description             |
| ---------- | ----------------------- |
| `--query`  | 默认发送 query 类型请求 |
| `--update` | 发送 updatle 类型请求   |

### Options

| Option                          | Description                           |
| ------------------------------- | ------------------------------------- |
| `--expire-after` <EXPIRE_AFTER> | 指定消息的有效时间，默认是 300s       |
| `--file`  <FILE>                | 指定输出文件名，默认是 message.json   |
| `--random` <RANDOM>             | 指定生成随机参数的配置                |
| `--type` {<TYPE>                | 指定调用参数的数据类型，比如 idl、raw |

### Arguments

| Argument        | Description    |
| --------------- | -------------- |
| `canister_name` | 指定容器名     |
| `method_name`   | 指定调用方法名 |
| `argument`      | 指定参数       |

### Examples

 使用 dfx canister sign 命令创建一个带签名的 message.json 文件

`dfx canister --network=ic sign --expire-after=1h rno2w-sqaaa-aaaaa-aaacq-cai create_neurons ‘(“PUBLIC_KEY”)’`

在这个示例中，您需要在 55 分钟之后和 60 分钟之前发送消息，以便将该消息识别为有效消息

## 容器基本操作

启动已经停止的容器、获取容器状态、停止容器等操作比较好理解，示例如下：

```bash
dfx canister start --all
dfx canister status --all
dfx canister stop --all
```
## dfx canister uninstall-code
----

使用 `dfx canister uninstall-code` 命令来卸载正在运行的罐的代码

这个方法删除容器的代码和状态，让容器再次变空

执行命令后，罐现是空的，任何传入或排队的呼叫都将被拒绝

### Basic usage

``` bash
dfx canister uninstall-code [flag] [--all | canister_name]
```

### Examples

``` bash
dfx canister --network=ic uninstall-code --all
```

## dfx canister update-settings
----

运行 `dfx canister update-settings` 命令来调整分配给容器罐的资源量。

### Basic usage

``` bash
dfx canister update-settings [flag] [canister_name]
```

### Flags

| Flag                                     | Description                                                                            |
| ---------------------------------------- | -------------------------------------------------------------------------------------- |
| `--add-controller`                       | 添加一个 principal 到控制器列表                                                        |
| `-c`, `--compute-allocation`             | 指定容器的 CPU 分配，范围 [0. .100] 中的百分比。                                       |
| `--controller`                           | 指定新控制器的标识名称或主体。                                                         |
| `--memory-allocation`                    | 指定容器总内存，范围 [0..12 GiB ]. 如何设置 0 时，当子网没有可用空间时，将可能停止运行 |
| `--remove-controller`                    | 删除一个 principal 到控制器列表                                                        |
| `--freezing-threshold`                   | 设置一个容器的冻结阈值（秒） ，这个值应该在 [0. . 2 ^ 64 ^-1] 的范围内                 |
| `--confirm-very-long-freezing-threshold` | 超过 1.5 年的冻结阈值需要这个参数作为确认。                                            |

### Examples

``` bash
dfx canister update-settings --freezing-threshold 2592000 --compute-allocation 99 hello_world
```