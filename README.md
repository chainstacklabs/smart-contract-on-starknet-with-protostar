# Create and deploy a smart contract on StarkNet

This tutorial will show you how to create a simple smart contract in Cairo to save and retrieve a variable and then deploy it on the StarkNet testnet using ProtoStar.

Cairo is a relatively new language that powers StarkNet`s smart contract; it is worth learning more about it! 

## Table of contents

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

## Full smart contrac

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

## Compile the smart contract

For this example, we'll use [protostar](https://github.com/software-mansion/protostar), one of the Starknet framework. 

First thing, [install Protostar](https://docs.swmansion.com/protostar/docs/tutorials/installation).

### Initialize a Protostar project]

After we installed Protostar, let's create a project by using the following command.

```sh
protostar init store-variable
```

Where `store-variable` is the name of the project.

The result of running protostar init is a configuration file `protostar.toml`, example files, and the following 3 directories:

* src — A directory for your code.
* lib — A default directory for external dependencies.
* tests — A directory storing tests.

** Work in progress **
