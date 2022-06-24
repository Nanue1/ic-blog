+++
title = "dfx 使用指南 - cache"
date = "2020-06-01"

[taxonomies]
tags = ["DFX"]
+++

# dfx cache

Use the `dfx cache` command with flags and subcommands to manage the `dfx` version cache.

The basic syntax for running `dfx cache` commands is:

使用带有标志和子命令的 dfx 缓存命令来管理 dfx 版本缓存

运行 dfx 缓存命令的基本语法是：

``` bash
dfx cache [subcommand] [flag]
```
根据您指定的 dfx 缓存子命令，可能会应用其他参数、选项和标志。有关说明如何使用 dfx 缓存命令的参考信息和示例，请选择适当的命令。

| Command   | Description                                                                   |
| --------- | ----------------------------------------------------------------------------- |
| `delete`  | Deletes the specified version of `dfx` from the local cache.                  |
| `help`    | Displays usage information message for a specified subcommand.                |
| `install` | Installs the specified version of `dfx` from the local cache.                 |
| `list`    | Lists the versions of `dfx` currently installed and used in current projects. |
| `show`    | Show the path of the cache used by this version of the `dfx` executable.      |

若要查看特定子命令的使用信息，请指定子命令和 `--help` 标志。例如，要查看 `dfx cache delete` 的使用信息，可以运行以下命令：

``` bash
dfx cache delete --help
```

## dfx cache delete

使用 `dfx cache delete` 命令从本地计算机的版本缓存中删除指定版本的 dfx。

### Basic usage

``` bash
dfx cache delete [version] [flag]
```

### Flags

可以在 `dfx cache delete` 命令中使用下列可选标志

| Flag              | Description                   |
| ----------------- | ----------------------------- |
| `-h`, `--help`    | Displays usage information.   |
| `-V`, `--version` | Displays version information. |

### Arguments

您可以为 dfx 缓存 delete 命令指定以下参数。

| Command   | Description                                                        |
| --------- | ------------------------------------------------------------------ |
| `version` | Specifies the version of `dfx` you to delete from the local cache. |

### Examples

您可以使用 `dfx cache delete` 命令永久删除您不再想使用的 dfx 版本。例如，可以运行以下命令来删除 dfx 版本 0.6.2:

``` bash
dfx cache delete 0.6.2
```

## dfx cache install

使用 dfx cache install 命令，使用当前在 dfx cache 中找到的版本安装 dfx。

### Basic usage

``` bash
dfx cache install [flag]
```

### Flags

可以在 dfx cache install 命令中使用以下可选标志。

| Flag              | Description                   |
| ----------------- | ----------------------------- |
| `-h`, `--help`    | Displays usage information.   |
| `-V`, `--version` | Displays version information. |

### Examples

可以使用 dfx cache install 命令强制从缓存中的版本安装 dfx。例如，可以运行以下命令来安装 dfx:

``` bash
dfx cache install
```

## dfx cache list

使用 `dfx cache list`命令列出您当前在项目中安装和使用的 dfx 版本。

如果安装了多个版本的 dfx，缓存列表将显示一个星号 (*) ，以指示当前活动版本。

### Basic usage

``` bash
dfx cache list [flag]
```

### Flags

可以在 `dfx cache list` 命令中使用下列可选标志。

| Flag              | Description                   |
| ----------------- | ----------------------------- |
| `-h`, `--help`    | Displays usage information.   |
| `-V`, `--version` | Displays version information. |

### Examples

您可以使用 `dfx cache list`命令来列出您当前在项目中安装和使用的 dfx 版本。例如，可以运行以下命令来列出在缓存中找到的 dfx 版本：

``` bash
dfx cache list
```
这个命令显示与下面类似的 dfx 版本列表：

``` bash
0.6.4 *
0.6.3
0.6.0
```

## dfx cache show

使用 `dfx cache show` 命令显示当前使用的 dfx 版本所使用的缓存的完整路径。

### Basic usage

``` bash
dfx cache show [flag]
```

### Flags

可以在 `dfx cache show` 命令中使用下列可选标志。

| Flag              | Description                   |
| ----------------- | ----------------------------- |
| `-h`, `--help`    | Displays usage information.   |
| `-V`, `--version` | Displays version information. |

### Examples

您可以使用 `dfx cache show` 命令来显示当前使用的 dfx 版本所使用的缓存的路径：

``` bash
dfx cache show
```
此命令显示当前使用的 dfx 版本所使用的缓存的路径：

``` bash
/Users/pubs/.cache/dfinity/versions/0.6.4
```
