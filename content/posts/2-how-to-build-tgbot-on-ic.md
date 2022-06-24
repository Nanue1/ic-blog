+++
title = "如何在 internet computer 上构建 telegram bot？"
date = "2021-11-10"
description = "当前 Internet computer（ICP） 上的 canister 无法对外发送 Http 请求，但可以通过 WebHook 的方式处理 telegram bot 的响应指令。这篇文章将介绍如何使用 WebHook 的方式构建一个 wasm 程序，部署到 ICP 分布式网络中。"

[taxonomies]
tags = ["Telegram", "ICP","Rust"]
+++
当前 Internet computer（ICP） 上的 canister 无法对外发送 Http 请求，但可以通过 WebHook 的方式处理 telegram bot 的响应指令。这篇文章将介绍如何使用 WebHook 的方式构建一个 wasm 程序，部署到 ICP 分布式网络中。

或许你会有疑惑，为什么非要将 telegram bot 部署到区块链上呢？当前我的 bot 程序都是部署在腾讯云的主机上，由于大陆网络无法直接访问到 telegram 的服务器，bot 程序想要运行，就必须在云主机上配置 proxy。在这种环境下， bot 程序经常会因为主机重启、代理变更等因素，无法提供稳定服务。假如 bot 程序部署在 ICP 网络中，就不会有这么多烦恼，此外 ICP 网络中的运行 canister 的费用要比云主机便宜的多。

## WebHook 方案介绍
----
### 1. 运行条件
首先，使用 WebHook 方式运行 bot 程序，需要哪些准备工作呢？
- 一台服务器
- 一个支持 https 的域名

当然，使用 ICP 网络就无需考虑这些问题，ICP 已经为网络中的每一个容器生成了一个访问域名，比如：https://hhkhq-piaaa-aaaah-qc3la-cai.raw.ic0.app

### 2. 交互方式
那么，telegram bot 的 WebHook 机制是如何运行的？
官方提供了两种方式让 bot 获取 Update 消息，一种是通过 getUpdates 的方式，需要 bot 定时拉取；另外一种方式，就是本文使用的方式，官方提供 setwebhook 接口，来为 bot 配置 Webhook 地址，用来接收 telegram 服务端推送的 Update 消息。相比而言，Webhook 的方式更高效一些。

通过  `curl https://api.telegram.org/bot$token/setWebhook?url=https://xxx.ic0.app` 配置 Webhook 地址后，telegram 服务端推送给 Webhook 端的内容结构是 [「Update」](https://core.telegram.org/bots/api#update) 消息类型，Webhook 端接收推送的文本消息可以这样处理：
```bash
curl --tlsv1.2 -v -k -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache"  -d '{
"update_id":10000,
"message":{
  "date":1441645532,
  "chat":{
     "last_name":"Test Lastname",
     "id":1111111,
     "first_name":"Test",
     "username":"Test"
  },
  "message_id":1365,
  "from":{
     "last_name":"Test Lastname",
     "id":1111111,
     "first_name":"Test",
     "username":"Test"
  },
  "text":"/start"
}
}' "https://YOUR.BOT.URL:YOURPORT/"

```
Webhook 端处理完消息后，返回的消息结构为 telegram 当前支持调用 [available-methods](https://core.telegram.org/bots/api#available-methods) 的方法名和参数的结合，比如返回一个发送视频的操作，需要调用 sendVideo 接口，此时 Webhook 返回结果为：
```json
{
    "caption": "视频描述",
    "chat_id": -1001338531522,
    "method": "sendVideo",
    "protect_content": true,
    "video": "BAACAgUAAx0CV6OWFwADuWK4YCOlbMrzsPu0kJjQ99uvHpoJAAIRBwAC_S5QVQh4rspUlxxxxx"
}
```

更多 WebHook 使用注意事项可以参考 [这里](https://core.telegram.org/bots/webhooks), 弄清楚 WebHook 方案的触发机制，以及各端的请求体和返回体结构后，便可以开始开发调试 bot 程序。

## WebAssembly bot 开发
----
### 1. api crate
开发 telegram bot 程序前，需要选择一个开源的 rust api 仓库，而且必须支持 Wasm 环境运行。可以通过`cargo check --target wasm32-unknown-unknown` 测试 crate 是否是一个适用于 Wasm 的 `#![no-std]`
 库。 
 
 在我苦苦寻找的过程中，我发现了 [ic-telergam-bot](https://github.com/nomeata/ic-telegram-bot), ^_^, 这不就是我想要实现的 wasm bot 吗？ 此项目使用了 [telergam-bot-raw](https://docs.rs/telegram-bot-raw/latest/telegram_bot_raw/) 实现了的 telegram 官方定义 request 方法和 types 消息体。

 ### 2. candid 接口定义
 外界网络环境想要与运行在 ICP 网络上的 WebHook bot 通信，需要通过 IDL 语言定义交互方式，Dfinity 团队提供了 [candid](https://github.com/dfinity/candid), 来帮我们实现接口描述和交换数据的定义。
 比如 Webhook Bot Canister 的接口描述可以像这样：
 ```json
 type request = record {
  method : text;
  headers : vec record {blob; blob};
  uri : text;
  body : blob;
};
type response = record {
  status : nat16;
  headers : vec record {blob; blob};
  body : blob;
  upgrade : bool;
};
service : {
  http_query : (request) -> (response);
  http_update : (request) -> (response);
}
 ```
到这里，便可以参考 ic-telergam-bot 来实现自己的 bot 程序。
 
## 部署发布
---- 
### 1. 编译与优化包大小
通过 [ic-cdk-optimizer](https://docs.rs/crate/ic-cdk-optimizer/latest/source/) 减小构建后 wasm 包大小
```bash
#!/bin/sh

cargo build --manifest-path $(dirname $0)/Cargo.toml --target wasm32-unknown-unknown --release || exit 1

CURRENT_DIR=`pwd`
cd $(dirname $0)/
cargo install ic-cdk-optimizer --root target || exit 1
STATUS=$?
cd $CURRENT_DIR

if [ "$STATUS" -eq "0" ]; then
  $(dirname $0)/target/bin/ic-cdk-optimizer \
      $(dirname $0)/target/wasm32-unknown-unknown/release/telegram.wasm \
      -o $(dirname $0)/target/wasm32-unknown-unknown/release/telegram-opt.wasm

  true
else
  false
fi
```
### 2. 发布

通过 `dfx deploy --network=ic --with-cycles 400000000000 --wallet tfsfh-haaaa-aaaah-qagdq-cai` 读取 dfx.json 内定义的构建发布行为

```json
{
  "canisters": {
    "telegram": {
      "build": "telegram/build.sh",
      "candid": "telegram/src/lib.did",
      "type": "custom",
      "wasm": "telegram/target/wasm32-unknown-unknown/release/telegram-opt.wasm"
    }
  },
  "networks": {
    "ic": {
      "providers": [
        "https://ic0.app"
      ],
      "type": "persistent"
    },
    "local": {
      "bind": "0.0.0.0:8080",
      "type": "ephemeral"
    }
  },
  "version": 1
}
```
### 3. 配置 Webhook 地址

通过 `./set-webhook.sh` 读取本地 token 文件内的 bot token，来配置 Webhook bot

```bash
#!/usr/bin/env bash

canister_id="$(jq -r .telegram.ic < canister_ids.json)"

if [ -z "$canister_id" ]; then
  echo "Could not read canister id for canister \"telegram\" from ./canister_ids"
  exit 1
fi

token="$(cat token)"
if [ -z "$token" ]; then
  echo "Could not read file ./token"
  exit 1
fi

curl "https://api.telegram.org/bot$token/setWebhook?url=https://$canister_id.raw.ic0.app/webhook/$token"
```
## 总结
----
- WebHook bot 方案的开发，需要理解背后的交互逻辑与交互内容的格式
- 不要过分依赖现有的 bot api 的实现，开发中无法满足的 methods 和 types, 可以自己定义，只要遵循 telegram 官方定义的 http 接口规范即可

## 参考
https://core.telegram.org/bots/webhooks

https://core.telegram.org/bots/api#available-methods

https://github.com/nomeata/ic-telegram-bot