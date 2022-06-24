+++
title = "dfx 使用指南 - deploy"
date = "2020-06-01"

[taxonomies]
tags = ["DFX"]
+++
# dfx deploy

`dfx deploy` 使您只运行一个命令，而不需要单独的运行以下命令，从而简化了开发人员工作流：

    dfx canister create --all
    dfx build
    dfx canister install --all

## Basic usage

``` bash
dfx deploy [flag] [option] [canister_name]
```

## Options

You can use the following options with the `dfx deploy` command.

| Option                             | Description |
|-------|----|
| `--network <network>`              |指定运行环境                                                            |
| `--argument <argument>`            |指定在部署期间使用 Candid 语法传递给容器的参数。请注意，此选项要求您在 Motoko 程序中定义一个 Actor 类|
| `--with-cycles <number-of-cycles>` | 使您能够指定项目中一个容器的初始周期数。  |

### Arguments

You can specify the following arguments for the `dfx deploy` command.

| Argument        | Description |
|-----------------|--------------------
| `canister_name` | 指定的 dfx.json 中定义的容器名称，如果不指定容器名称，dfx 部署将部署 dfx.json 文件中定义的所有容器 |

## Examples

例如：在 ic-pubs 网络中部署 hello 项目，可以运行以下命令：

``` bash
dfx deploy hello --network ic-pubs
```

部署时传递单个参数，可以运行类似于下面的命令：

``` bash
dfx deploy hello_actor_class --argument '("from DFINITY")'
```

请注意，当前您必须在 Motoko dapp 中使用 Actor 类。在本例中，dfx deploy 命令指定要传递给 hello_actor_class 容器的参数。hello_actor_class 容器的主程序如下所示：

    actor class Greet(name: Text) {
        public query func greet() : async Text {
            return "Hello, " # name # "!";
        };
    };

使用 `--with-cycles` 选项，为创建的容器指定初始 cycles

``` bash
dfx deploy --with-cycles 8000000000000 hello-assets
```
