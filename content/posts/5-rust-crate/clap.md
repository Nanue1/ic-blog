+++
title = "clap 命令行参数解析"
date = "2020-11-15"

[taxonomies]
tags = ["Crate"]
+++

clap 是 rust 语言中命令行参数解析器。开箱即用，用户可以获得精美的 CLI 体验。包括常见的参数行为、帮助生成、为用户建议的修复程序、彩色输出、 shell 完成等

clap 创建解析器支持 Derive 和 Builder 两种方式，Derive 方式的优点是更易读、修改，更容易重用, 一般会选择 Derive 方式。

## Derive  

```rust
use clap::{Parser,Subcommand};
use std::path::PathBuf;

#[derive(Parser)]
#[clap(author, version, about, long_about = None)]
struct Cli {
    /// Optional name to operate on
    #[clap(value_parser)]
    name: Option<String>,

    /// Sets a custom config file
    #[clap(short, long, value_parser, value_name = "FILE")]
    config: Option<PathBuf>,

    /// Turn debugging information on
    #[clap(short, long, action = clap::ArgAction::Count)]
    debug: u8,

    #[clap(subcommand)]
    command: Option<Commands>,
}

#[derive(Subcommand)]
enum Commands {
    /// does testing things
    Test {
        /// lists test values
        #[clap(short, long, action)]
        list: bool,
    },
}

#[allow(dead_code)]
pub fn derive_parser() {
    let cli = Cli::parse();
    // You can check the value provided by positional arguments, or option arguments
    if let Some(name) = cli.name.as_deref(){
        println!("Value for name: {}", name);
    }

    if let Some(config_path) = cli.config.as_deref() {
        println!("Value for config: {}", config_path.display());
    }

    // You can see how many times a particular flag or argument occurred
    // Note, only flags can have multiple occurrences
    match cli.debug {
        0 => println!("Debug mode is off"),
        1 => println!("Debug mode is kind of on"),
        2 => println!("Debug mode is on"),
        _ => println!("Don't be crazy"),
    }

    // You can check for the existence of subcommands, and if found use their
    // matches just as you would the top level cmd
    match &cli.command {
        Some(Commands::Test { list }) => {
            if *list {
                println!("Printing testing lists...");
            } else {
                println!("Not printing testing lists...");
            }
        }
        None => {}
    }

    // Continued program logic goes here...

}

```

## Builder 

```rust 
use std::path::PathBuf;
use clap::{arg, command, value_parser, ArgAction, Command};

#[allow(dead_code)]
pub fn build_parser(){
    let matches = command!() // requires `cargo` feature
        .arg(arg!([name] "Optional name to operate on"))
        .arg(
            arg!(
                -c --config <FILE> "Sets a custom config file"
            )
            // We don't have syntax yet for optional options, so manually calling `required`
            .required(false)
            .value_parser(value_parser!(PathBuf)),
        )
        .arg(
            arg!(
                -d --debug "Turn debugging information on"
            )
            .action(ArgAction::Count),
        )
        .subcommand(
            Command::new("test")
                .about("does testing things")
                .arg(arg!(-l --list "lists test values").action(ArgAction::SetTrue))
        )
        .get_matches();

    // You can check the value provided by positional arguments, or option arguments
    if let Some(name) = matches.get_one::<String>("name") {
        println!("Value for name: {}", name);
    }

    if let Some(config_path) = matches.get_one::<PathBuf>("config") {
        println!("Value for config: {}", config_path.display());
    }

    // You can see how many times a particular flag or argument occurred
    // Note, only flags can have multiple occurrences
    match matches
        .get_one::<u8>("debug")
        .expect("Count's are defaulted")
    {
        0 => println!("Debug mode is off"),
        1 => println!("Debug mode is kind of on"),
        2 => println!("Debug mode is on"),
        _ => println!("Don't be crazy"),
    }

    // You can check for the existence of subcommands, and if found use their
    // matches just as you would the top level cmd
    if let Some(matches) = matches.subcommand_matches("test") {
        // "$ myapp test" was run
        if *matches.get_one::<bool>("list").expect("defaulted by clap") {
            // "$ myapp test -l" was run
            println!("Printing testing lists...");
        } else {
            println!("Not printing testing lists...");
        }
    }

    // Continued program logic goes here...
}
```

# 常用的 Derive Macro 
使用 Derive 解析器时，通过 #[clap(value_enum)] 的方式，为参数添加 clap 提供的内置能力

```rust 
#[derive(Parser)]
struct Args {
    #[clap(value_enum)]
    network: Network,
    #[clap(long, conflicts_with("sha2"), requires("file"), group("hash"))]
    sha2_auto: bool,
}

#[derive(Clone, ValueEnum)]
pub enum Network {
    Ic,
    Local,
}
```