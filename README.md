# Create and deploy a smart contract on StarkNet

This tutorial will show you how to create a simple smart contract in Cairo to save and retrieve a variable and then deploy it on the StarkNet testnet using ProtoStar.

Cairo is a relatively new language that powers StarkNet's smart contracts; it is worth learning more about it! 

## Table of contents

  - [Cairo smart contract](#cairo-smart-contract)
    - [The smart contract head](#the-smart-contract-head)
    - [Declare a variable](#declare-a-variable)
    - [Getter function](#getter-function)
    - [Function to set the variable](#function-to-set-the-variable)
  - [Full smart contract](#full-smart-contract)
  - [A Protostar project](#a-protostar-project)
    - [Initialize a Protostar project](#initialize-a-protostar-project)
    - [Compile the Cairo smart contract](#compile-the-cairo-smart-contract)
    - [Deploy the smart contract on testnet](#deploy-the-smart-contract-on-testnet)
  - [Interact with the deployed contract](#interact-with-the-deployed-contract)
  - [Conclusion](#conclusion)

## Cairo smart contract

The smart contract we'll write in this tutorial is straightforward, but it will teach you how to declare a variable, write a getter function, and write a function to set the variable. 

### The smart contract head

The first thing we need is to declare it as a StarkNet contract and importing the 'HashBuiltin' package.

```cairo
%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin
```

At this point, we can continue by declaring the variable.

### Declare a variable

Like Solidity, we need to declare a variable to use it. In this example, the variable is a 'felt', named 'my_value_storage', where we can basically store a number.

```cairo
@storage_var
func my_value_storage() -> (my_value_storage: felt) {
}
```

Storage variables are, by default, not visible from the ABI. They are similar to "private" variables in Solidity.

> A storage variable can be read with `var_name.read()` or written to with `var_name.write()`.

### Getter function

When we use variables, it is good practice to declare a 'getter' function. So we can add that too!

A getter is a view function that we can call to see the stored variable.

```cairo
@view
func get_my_stored_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    my_stored_value: felt
) {
    let (my_stored_value) = my_value_storage.read();
    return (my_stored_value,);
}
```

> For example, this function can be called from the StarkNet explorer and display the stored value. 

### Function to set the variable

Now that we have the variable declared, how do we modify it? 
We could automatically set it up when the contract is deployed with a 'constructor', but for this tutorial, I want to create a function for it.

This is an 'external' function, which can be called by another smart contract (or wallet), allowing us to modify that variable!

```cairo
@external
func set_my_stored_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
my_value: felt,
) {
    my_value_storage.write(my_value);
    return ();
}
```

As you notice, in the function to set a stored value, we use `my_value_storage.write(my_value)`, where `my_value` is the argument passed through the function.

## Full smart contract

Now that we have all the separate parts, we can put them together. Here you'll find the entire smart contract, with some comments.

```cairo
%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin

// Store a variable
// Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity.

// This variable is a felt and is called my_value_storage
// From within a smart contract, it can be read with my_value_storage.read() or written to with my_value_storage.write()

@storage_var
func my_value_storage() -> (my_value_storage: felt) {
}

// Declaring getters
// Public variables should be declared explicitly with a getter
// Function to return the variable's value.

@view
func get_my_stored_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    my_stored_value: felt
) {
    let (my_stored_value) = my_value_storage.read();
    return (my_stored_value,);
}

// Set the variable's value.

@external
func set_my_stored_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
my_value: felt,
) {
    my_value_storage.write(my_value);
    return ();
}
```

## A Protostar project

For this example, we'll use [protostar](https://github.com/software-mansion/protostar), one of the Starknet framework. 

First thing, [install Protostar](https://docs.swmansion.com/protostar/docs/tutorials/installation).

### Initialize a Protostar project

After we installed Protostar, let's create a project by using the following command.

```sh
protostar init store-variable
```

Where `store-variable` is the name of the project.

The result of running protostar init is a configuration file `protostar.toml`, example files, and the following 3 directories:

* src — A directory for your code.
* lib — A default directory for external dependencies.
* tests — A directory storing tests.

The `protostar.toml` file is the configuration file where we specify the path to our contracts; in this case, you'll already have a `cairo.main` example file. 

In this case, we will generate a contract named `main` from our `src` folder.

```
["protostar.contracts"]
main = [
    "src/main.cairo",
]
```

Simply delete the example code and paste our smart contract's code. 

### Compile the Cairo smart contract

We have initialized a Protostar project, and there is a Cairo smart contract is in the `src` folder; we are ready to compile.

From the project main directory, run the following command to compile.

```sh
protostar build
```
You will receive a success message if the contract is compiled correctly.

```sh
16:23:13 [INFO] Built the project successfully                                                                                                             
16:23:14 [INFO] Execution time: 2.96 s
```

After the contract has been compiled, you will notice a `build` directory in the project, where you can find the contract's ABI and the compiled contract as `main.json`.

### Deploy the smart contract on testnet

After the smart contract was compiled, we can finally use Protostar to deploy it on the StarkNet testnet.

Use the following command to deploy the compiled contract.

```sh
protostar deploy ./build/main.json --network testnet
```

The result will show you the transaction hash and the contract address and give you a link to the smart contract on the Voyager explorer. 

```sh
[INFO] Deploy transaction was sent.
Contract address: 0x06a5ea9e42c921bd58e24b8da9d1fc91a488df0700b173f1c6bb0e453f68afec
Transaction hash: 0x1cbba90ba0d1fbfba09b1f7a0f987134dd9a02a845ca89244b3272374d37ede

https://goerli.voyager.online/contract/0x06a5ea9e42c921bd58e24b8da9d1fc91a488df0700b173f1c6bb0e453f68afec
```

## Interact with the deployed contract

Now that the smart contract has been deployed, you can use the Voyager explorer to interact with it.

You can use the [smart contract we deployed](https://goerli.voyager.online/contract/0x010c484443bafd91e255e7326676f146f825a1cbc1d69a711eb04186b2e2a734#readContract) if you still need to deploy yours. 

Use the `Read Contract` tab to call the `view` function and see the stored value. 

![screely-1667331609005](https://user-images.githubusercontent.com/99700157/199323621-7cb1a281-d5f4-434a-a8c0-d55a0c721ba4.png)

Then you can use the `Write Contract` tab to call the `external function` and modify the value.

![screely-1667331661106](https://user-images.githubusercontent.com/99700157/199323759-4ed4d165-eeab-4429-8cdf-175ac89a4562.png)

## Conclusion

Congratulations on completing this tutorial. Today you learned how to write and deploy a simple smart contract in Cairo!
