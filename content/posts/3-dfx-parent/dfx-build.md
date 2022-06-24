+++
title = "dfx 使用指南 - build"
date = "2020-06-01"

[taxonomies]
tags = ["DFX"]
+++

# dfx build

使用 `dfx build` 命令将程序编译成可部署在 IC 上的 WebAssembly 模块。
您可以使用此命令来编译当前项目下 dfx.json`内定义的所有程序，也可以指定单个罐编译。

注意，只能在项目目录结构中运行此命令。例如，如果项目名称为 hello _ world，则当前工作目录必须是 hello _ world 目录或其子目录之一。

dfx build 命令使用你在 dfx.json 文件中的 canister 下配置的信息来编译源码

## 基本用法

``` bash
dfx build [flag] [option] [--all | canister_name]
```

## Flags

| Flag              | Description                                                                              |
| ----------------- | ---------------------------------------------------------------------------------------- |
| `--check`         | 在不连接 IC 的情况下，使用临时的、硬编码、本地定义的 canister identifier, 来测试编译程序 |
| `-h`, `--help`    | 显示使用信息。                                                                           |
| `-V`, `--version` | 显示版本信息。                                                                           |

## Options

| Option                | Description                                                                      |
| --------------------- | -------------------------------------------------------------------------------- |
| `--network <network>` | 指定要连接到的网络别名或 URL。可以使用此选项覆盖 dfx.json 配置文件中指定的网络。 |

## Arguments

| Argument        | Description                                           |
| --------------- | ----------------------------------------------------- |
| `--all`         | 构建`dxf.json`中配置的所有罐                          |
| `canister_name` | 指定罐名构建 （指定的罐名必须在`dfx.json`中已经定义） |

## Examples

您可以使用 `dfx build` 命令构建`dfx,json` 内 `canisters`中指定的，一个或多个 WebAssembly 模块。例如下面的 `dfx.json` 定义了一个 `hello_world` 罐和一个 `hello_world_asset` 罐，那么运行 `dfx build` 将编译两个 WebAssembly 模块。
```json
{
  "canisters": {
    "hello_world": {
      "main": "src/hello_world/main.mo",
      "type": "motoko"
    },
    "hello_world_assets": {
      "dependencies": [
        "hello_world"
      ],
      "frontend": {
        "entrypoint": "src/hello_world_assets/public/index.js"
      },
      "source": [
        "src/hello_world_assets/assets",
        "dist/hello_world_assets/"
      ],
      "type": "assets"
    }
  },
  "defaults": {
    "build": {
      "packtool": ""
    }
  },

  "dfx": "0.9.3",
  "networks": {
    "local": {
      "bind": "127.0.0.1:8000",
      "type": "ephemeral"
    },
    "ic": {
      "providers": [
        "https://gw.dfinity.network"
      ],
      "type": "persistent"
    }
  },
  "version": 1
}

```

在本例中，`hello_world` 罐存储后端代码和 `hello_world_asset` 罐存储前端代码和资产。如果希望只构建后端程序，可以运行以下命令：

``` bash
dfx build hello_world
```

当您在 `dfx.json` 文件中定义了多个罐，但希望独立测试和调试罐的操作时，构建特定的罐非常有用。

要测试罐是否可以在不连接 IC 或本地罐执行环境的情况下进行编译，可以运行以下命令：

``` bash
dfx build --check
```
