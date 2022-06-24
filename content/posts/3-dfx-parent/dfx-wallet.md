+++
title = "dfx 使用指南 - wallet"
date = "2020-06-01"

[taxonomies]
tags = ["DFX"]
+++
# dfx wallet

使用 `dfx wallet` 命令管理你身份下的 cycles 钱包，发送 cycles 到其他账号下的 cycles 钱包容器

```bash
dfx wallet [option] <subcommand> [flag]
```

| Command             | Description                                                                                                                                      |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `add-controller`    | Add a controller using the selected identity's principal.                                                                                        |
| `addresses`         | Displays the address book of the cycles wallet.                                                                                                  |
| `authorize`         | Authorize a custodian by principal for the selected identity's cycles wallet                                                                     |
| `balance`           | Displays the cycles wallet balance of the selected identity.                                                                                     |
| `controllers`       | Displays a list of the selected identity's cycles wallet controllers.                                                                            |
| `custodians`        | Displays a list of the selected identity's cycles wallet custodians.                                                                             |
| `deauthorize`       | Deauthorize a cycles wallet custodian using the custodian's principal.                                                                           |
| `help`              | Displays a usage message and the help of the given subcommand(s).                                                                                |
| `name`              | Returns the name of the cycles wallet if you've used the `dfx wallet set-name` command.                                                          |
| `remove-controller` | Removes a specified controller from the selected identity's cycles wallet.                                                                       |
| `send`              | Sends a specified amount of cycles from the selected identity's cycles wallet to another cycles wallet using the destination wallet canister ID. |
| `set-name`          | Specify a name for your cycles wallet.                                                                                                           |
| `upgrade`           | Upgrade the cycles wallet's Wasm module to the current Wasm bundled with DFX.                                                                    |

## Using your wallet

After you have used the `dfx identity deploy-wallet` command to create a cycles wallet canister tied to an identity, you can use `dfx wallet` commands to modify your cycles wallet settings, send cycles to other cycles wallets, and add or remove controllers and custodians. 

## dfx wallet add-controller

使用 `dfx wallet add-controller` 向钱包添加控制器。分配给 Controller 角色拥有最多的特权，可以执行以下操作：

* 重命名周期钱包

* Add entries to the address book.

* 添加和删除控制器。

* 授权和解除对保管人的授权

控制器也是保管人，可以执行与该角色相关的下列行动：

* 获取钱包信息。

* 发送周期。

* 转发请求

* 创建罐

### Examples

```
dfx wallet --network=https://192.168.74.4 add-controller hpff-grjfd-tg7cj-hfeuj-olrjd-vbego-lpcax-ou5ld-oh7kr-kl9kt-yae
```

## dfx wallet addresses

Use the `dfx wallet addresses` command to display the wallet's address book.The address entries contain the principal and `role` (`Contact`, `Custodian`, or `Controller`), and might contain a `name`, and `kind` (`Unknown`, `User`, or `Canister`) associated with the address.

### Basic usage

```
dfx wallet addresses
```

### Examples

You can use the `dfx wallet addresses` command to retrieve information on the addresses in your wallet's address book. For example:

```
dfx wallet addresses
Id: hpff-grjfd-tg7cj-hfeuj-olrjd-vbego-lpcax-ou5ld-oh7kr-kl9kt-yae, Kind: Unknown, Role: Controller, Name: ic_admin.
Id: e7ptl-4x43t-zxcvh-n6s6c-k2dre-doy7l-bbo6h-ok8ik-msiz3-eoxhl-6qe, Kind: Unknown, Role: Custodian, Name: alice_auth.
```

## dfx wallet authorize

Use the `dfx wallet authorize` command to authorize a custodian for the wallet. An identity assigned the role of custodian can perform the following actions on the cycles wallet:

* Access wallet information.

* Send cycles.

* Forward calls.

* Create canisters. 

### Basic usage

```
dfx wallet authorize <custodian> [flag]
```

### Arguments

Use the following necessary argument with the `dfx wallet authorize` command.

| Argument      | Description                                                                                                          |
| ------------- | -------------------------------------------------------------------------------------------------------------------- |
| `<custodian>` | Specify the principal of the identity you would like to add as a custodian to the selected identity's cycles wallet. |

### Example

For example, to add alice_auth as a custodian, specify her principal in the following command:

```
dfx wallet authorize dheus-mqf6t-xafkj-d3tuo-gh4ng-7t2kn-7ikxy-vvwad-dfpgu-em25m-2ae
```

## dfx wallet balance

Use the `dfx wallet balance` command to display the balance of the cycles wallet of the selected identity. 

```
dfx wallet balance
```

## dfx wallet controllers

Use the `dfx wallet controllers` command to list the principals of the identities that are controllers of the selected identity's cycles wallet. 

```
dfx wallet controllers
```

## dfx wallet custodians

```
dfx wallet custodians
```

## dfx wallet deauthorize

Use the `dfx wallet deauthorize` command to remove a custodian from the cycles wallet. 

NOTE:  that this will also remove the role of controller if the custodian is also a controller.

```
dfx wallet deauthorize dheus-mqf6t-xafkj-d3tuo-gh4ng-7t2kn-7ikxy-vvwad-dfpgu-em25m-2ae
```

## dfx wallet name

```
dfx wallet name 
```

## dfx wallet remove-controller

Use the `dfx wallet remove-controller` command to remove a controller of your selected identity's cycles wallet.

```
dfx wallet remove-controller dheus-mqf6t-xafkj-d3tuo-gh4ng-7t2kn-7ikxy-vvwad-dfpgu-em25m-2ae
```

## dfx wallet send

Use the `dfx wallet send` command to send cycles from the selected identity's cycles wallet to another cycles wallet using the destination cycle wallet's Canister ID. 

### Basic usage

```
dfx wallet [network] send [flag] <destination> <amount> 
```

### Arguments

You must specify the following arguments for the `dfx wallet send` command.

| Argument        | Description                                                 |
| --------------- | ----------------------------------------------------------- |
| `<destination>` | Specify the destination cycle wallet using its Canister ID. |
| `<amount>`      | Specify the number of cycles to send.                       |

### Examples

Send cycles from the selected identity's cycles wallet to another cycles wallet.

For example, to send 2,000,000,000 cycles from the cycles wallet of the selected identity, `<ic_admin>`, to the cycles wallet of the destination identity, `<buffy_standard>` with a wallet address `r7inp-6aaaa-aaaaa-aaabq-cai`, run the following command:

```
dfx wallet send r7inp-6aaaa-aaaaa-aaabq-cai 2000000000
```

## dfx wallet set-name

Use the `dfx wallet set-name` command to assign a name to the selected identity's cycles wallet.

### Basic usage

```
    dfx wallet set-name [flag] <name> 
```

If you want to set the name of the current identity's cycles wallet to "Terrances_wallet" you can run the following command:

```
dfx wallet set-name Terrances_wallet
```

## dfx wallet upgrade

To upgrade the Wasm module to the latest version, run the following command:

```
dfx wallet upgrade
```
