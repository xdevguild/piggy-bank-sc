#![no_std]

elrond_wasm_node::wasm_endpoints! {
    piggybank
    (
        init
        createPiggy
        addAmount
        payOut
        getLockedAmount
        getLockTime
    )
}
