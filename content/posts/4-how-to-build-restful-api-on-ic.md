+++
title = "如何在 IC 上构建 restful api 接口 ？"
date = "2021-11-12"
description = "当前 Internet computer（ICP） 上的 canister 无法对外发送 Http 请求，但可以接收 HTTP 请求进行响应处理。"

[taxonomies]
tags = ["ICP"]
+++
当前 Internet computer（ICP） 上的 canister 无法对外发送 Http 请求，但可以接收 HTTP 请求进行响应处理。

在尝试用 Rust 尝试前端开发过程中，IC 容器联调测试本地后端接口时，经常会遇到跨域问题。此时直接将 restful api 直接部署到 IC 的公网环境，方便开发联调。

## http 请求如何工作的？

## get/post 请求如何定义？

## ic 网络上的性能如何测试？

## 问题排查
1. 为什么 icx-proxy 无法转发 /api/v1 ,但是 /v1/api/ 是可以转发?