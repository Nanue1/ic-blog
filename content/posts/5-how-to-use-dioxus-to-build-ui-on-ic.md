+++
title = "如何在 internet computer 上基于 dioxus 实现前端？"
date = "2021-11-13"
description = "dioxus 是 Rust 前端框架，用 Rust语言实现 UI 界面，部署在 Internet computer（ICP） 上可行吗？"

[taxonomies]
tags = ["Dioxus", "ICP"]
+++

## dioxus 项目
是一个 bin 类型的，不是cdylib，
ic 的 rust 类型容器是只支持 cdylib 类型的吗

```toml
[lib]
crate-type = ["cdylib"]
```

部署只能是一个 assets 类型才能正常运行前端服务



## 如何与容器交互

```rust
#[import(canister = "rust_hello")]
struct RustHello;
```
为何一直无法导入？
Could not find DFX bindings for canister named 'rust_hello'. Did you build using DFX?


1. cargo 正常编译如何通过呢？

查源码 需要环境变量

todo 


``` shell  
src/rust_hello_dioxus [lxc●] » sh build.sh
2022-07-09T18:46:33.221675Z  INFO 📦 starting build
2022-07-09T18:46:33.224278Z  INFO spawning asset pipelines
2022-07-09T18:46:33.860672Z  INFO building rust_hello_dioxus
   Compiling rust_hello_dioxus v0.1.0 (/Users/manue1/github/meituan/lixuchun/rust/dfx/rust_hello/src/rust_hello_dioxus)
error: Could not find DFX bindings for canister named 'rust_hello'. Did you build using DFX?
 --> src/rust_hello_dioxus/src/lib.rs:5:1
  |
5 | #[import(canister = "rust_hello")]
  | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  |
  = note: this error originates in the attribute macro `import` (in Nightly builds, run with -Z macro-backtrace for more info)

error: could not compile `rust_hello_dioxus` due to previous error
2022-07-09T18:46:35.342308Z ERROR ❌ error
error from HTML pipeline
```


2. trunk 如何编译?
   type 必须是 rust 类型才能通过 dfx 编译
   assets 类型的
   对于 rust 写的 assets类型的项目，如何通过dfx编译呢？



## 通过rpc 引入方案
如何 call 一个网络中的容器呢?

https://k7gat-daaaa-aaaae-qaahq-cai.ic0.app/listing/internet-identity-10235/rdmx6-jaaaa-aaaaa-aaadq-cai


https://k7gat-daaaa-aaaae-qaahq-cai.ic0.app/docs/


https://kyle-peacock.com/blog/dfinity/working-with-candid/



## ic-agent 

no-std 包导致 dioxus 无法编译成 wasm包
