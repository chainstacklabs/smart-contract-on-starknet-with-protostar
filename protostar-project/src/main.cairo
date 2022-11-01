%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin

// Store a variable
// Storage variables are by default not visible through the ABI. They are similar to "private" variables in Solidity.

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