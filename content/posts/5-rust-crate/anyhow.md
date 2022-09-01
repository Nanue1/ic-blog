+++
title = "anyhow  错误处理"
date = "2020-11-15"

[taxonomies]
tags = ["Crate"]
+++

anyhow 提供了通用的错误处理能力，使用 Result<T, anyhow::Error> , 或是 anyhow::Result<T>， 作为任何可能报错函数的返回类型。在函数内，使用 `?` 传递实现了 std::error::Error trait 的错误


## anyhow::Result

```rust
fn main() {
    println!("Hello, world!");
    let cluster = get_cluster_info().unwrap();
    println!("cluster: {:?}", cluster)
}

fn get_cluster_info() -> Result<ClusterMap> {
    let config = fs::read_to_string("./src/cluster.json")?;
    let map: ClusterMap = serde_json::from_str(&config)?;
    Ok(map)
}

#[derive(Debug,Deserialize)]
#[allow(dead_code)]
struct ClusterMap {
    name: String,
    nodes: Vec<String>,
}
```
假如此时，未创建文件，会出现下面报错.

```bash
rs-test/anyhow-test [main●] » target/debug/anyhow-test                                                                                              │z67sb-pfgvc-okg75-6m7g4-pd7rg-eae/ic_consensus/consensus starvation detected: Finalizer has not been invoked for 283.713547
Hello, world!                                                                                                                                       │s
thread 'main' panicked at 'called `Result::unwrap()` on an `Err` value: No such file or directory (os error 2)', src/main.rs:7:38                   │Sep 01 00:20:14.930 WARN s:ra7mo-we4hy-jcriu-eessl-ayyl2-f6njr-oijr4-zywh6-p3tom-dubrt-5qe/n:nmqv2-f4pmr-tvm4z-k5yxb-xaxk5-
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
可以看出,通过 anyhow::Result , 可以方便 Error 信息的传递，但这个信息无法定位具体的错误细节。

## anyhow::Context

通过 context 方法，在上下文内，可以添加详细的错误描述,实现 wrap error 的能力

```rust
fn parse_impl(mut file: File) -> Result<ClusterMap> {
    let mut contents = String::new();
    file.read_to_string(&mut contents).context("read file contents to string")?;
    let map: ClusterMap = serde_json::from_str(&contents).context("deserialize cluster map to string")?;
    Ok(map)
}

pub fn parse(path: impl AsRef<Path>) -> Result<ClusterMap> {
    let path_str = path.as_ref().to_str().unwrap();
    let file = File::open(&path).context(format!("read file {path_str} failed."))?;
    parse_impl(file)
}
```

```bash
rs-test/anyhow-test [main●] » target/debug/anyhow-test
Hello, world!
thread 'main' panicked at 'called `Result::unwrap()` on an `Err` value: read file /tmp/foo/bar.txt failed.

Caused by:
    No such file or directory (os error 2)', src/main.rs:11:31
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```


## anyhow::bail

提前返回错误
```rust
if !has_permission(user, resource) {
    bail!("permission denied for accessing {}", resource);
}
```