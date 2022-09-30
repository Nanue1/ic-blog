+++
title = "tokio 一个用于执行异步代码的多线程运行时"
date = "2020-11-15"

[taxonomies]
tags = ["Crate"]
+++

tokio 是 Rust 编程语言的一个异步运行时。它提供了编写网络应用所需的构建模块。

## macros 特性

tokio 提供了执行异步任务的运行时。大多数应用程序可以使用 `#[tokio::main]` 宏在 tokio 运行时上运行它们的代码。`tokio::runtime`模块为配置和管理运行时提供了更强大的 API

## rt 特性

`tokio::task` 模块，作为 Rust 中轻量级非阻塞执行单元，只有在启用 rt(runtime) 特性标志时才能使用。

## sync 特性

`tokio::sync` 模块包含同步原语，用于需要通信或共享数据时使用

channels (oneshot, mpsc, watch, and broadcast) 用于 task 之间传递值的通道

## time 特性

`tokio::time` 模块提供了用于跟踪时间和调度工作的实用程序。这包括用于设置任务超时、任务睡眠时间等操作。

## 异步 IO

Tokio 还包括用于执行各种 I/O 和与操作系统异步交互的 API，其中包括：

### `tokio::net`

包含 TCP、 UDP 和 Unix 域套接字的非阻塞版本（通过`net`特性标志启用） 

### `tokio::fs`

类似于 `std::fs`，但是用于异步执行文件系统 I/O （通过`fs`特性标志启用）

### `tokio::signal`

对于异步处理 Unix 和 Windows 操作系统信号（通过`signal`特性标志启用

### `tokio::process`

用于产生和管理子进程（通过`process`特性标志启用）

## wasm support 

Tokio 对 WASM 平台的支持有限：
- sync
- macros
- io-util
- rt
- time