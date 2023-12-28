// Code generated by the multiversx-sc build system. DO NOT EDIT.

////////////////////////////////////////////////////
////////////////// AUTO-GENERATED //////////////////
////////////////////////////////////////////////////

// Init:                                 1
// Endpoints:                            6
// Async Callback (empty):               1
// Total number of exported functions:   8

#![no_std]

// Configuration that works with rustc < 1.73.0.
// TODO: Recommended rustc version: 1.73.0 or newer.
#![feature(lang_items)]

multiversx_sc_wasm_adapter::allocator!();
multiversx_sc_wasm_adapter::panic_handler!();

multiversx_sc_wasm_adapter::endpoints! {
    piggybank
    (
        init => init
        upgrade => upgrade
        createPiggy => create_piggy
        addAmount => add_amount
        payOut => pay_out
        getLockedAmount => locked_amount
        getLockTime => lock_time
    )
}

multiversx_sc_wasm_adapter::async_callback_empty! {}
