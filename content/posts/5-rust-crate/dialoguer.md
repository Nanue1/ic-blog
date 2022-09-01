+++
title = "dialoguer 简单的命令行交互操作"
date = "2020-11-15"

[taxonomies]
tags = ["Crate"]
+++

dialoguer 提供了简单的命令行交互操作。


##  交互式提示信息

```rust
// Confirmation prompts
#[allow(dead_code)]
fn confirmation_prompt() -> Result<()> {
    if Confirm::new().with_prompt("do you want to continue?").interact()?{
        println!("continue.");
    }else {
        println!("no continue");
    }
    return Ok(())
}
```

## 交互式编辑文本内容

```rust 
#[allow(dead_code)]
fn editor() -> Result<()> {
    if let Some(rv) = Editor::new().edit("Enter a commit message").unwrap(){
        println!("Your message:");
        println!("{}", rv);
    }else {
        println!("Abort!");
    }
    Ok(())
}
```

## 单选
```rust
// fuzzy select
#[allow(dead_code)]
fn fuzzy_select() -> Result<()> {
    let items = vec!["Item 1", "item 2"];
    let selection = FuzzySelect::with_theme(&ColorfulTheme::default())
        .items(&items)
        .default(0)
        .interact_on_opt(&Term::stderr())?;
    match selection {
        Some(index) => println!("User selected item : {}", items[index]),
        None => println!("User did not select anything")
    }
    Ok(())
}
```

## 输入校验
```rust
// Input validation
#[allow(dead_code)]
fn input() -> Result<()>{
    let input : String = Input::new()
        .with_prompt("Tea or coffee?")
        .with_initial_text("Yes")
        .default("No".into())
        .interact_text()?;
    println!("input :{}",input);
    Ok(())
}
```

## 多选
```rust
#[allow(dead_code)]
fn multipleSelect() -> Result<()>{
    let items = vec!["Option 1", "Option 2"];
    let chosen : Vec<usize> = MultiSelect::new()
        .items(&items)
        .interact()?;
    println!("chosen: {},",chosen[0]);
    Ok(())
}
```

## 密码输入
```rust
#[allow(dead_code)]
fn password()-> Result<()> {
    let password = Password::new().with_prompt("New Password")
        .with_confirmation("Confirm password", "Passwords mismatching")
        .interact()?;
    println!("Length of the password is: {}", password.len());
    Ok(())
}
```

## 交互式多项排序
```rust
#[allow(dead_code)]
fn sort() -> Result<()> {
    let items_to_order = vec!["Item 1", "Item 2", "Item 3"];
    let ordered = Sort::new()
        .with_prompt("Order the items")
        .items(&items_to_order)
        .interact()?;
    for x in ordered {
        println!("{}", x);
    }
    Ok(())
}
```