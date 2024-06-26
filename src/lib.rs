// We dont want a standard library here
#![no_std]

// MultiversX imports
use multiversx_sc::imports::*;

// Proxy generated by 'sc-meta all proxy --path ./src'
// https://docs.multiversx.com/developers/meta/sc-config
// https://docs.multiversx.com/developers/meta/sc-meta-cli
pub mod piggybank_proxy;

// Reference: https://docs.multiversx.com/developers/developer-reference/sc-annotations/#multiversx_sccontract
#[multiversx_sc::contract]
pub trait PiggyBank {
    // Reference: https://docs.multiversx.com/developers/developer-reference/sc-annotations/#init
    #[init]
    fn init(&self) {}

    // It will trigger with smart contract upgrade
    #[upgrade]
    fn upgrade(&self) {}

    // createPiggy endpoint (endpoint reference: https://docs.multiversx.com/developers/developer-reference/sc-annotations/#endpoint-and-view)
    #[endpoint(createPiggy)]
    fn create_piggy(&self, lock_time: u64) {
        // get smart contract caller address (reference: https://docs.multiversx.com/developers/developer-reference/sc-api-functions/#get_caller)
        let caller = &self.blockchain().get_caller();
        require!(
            self.lock_time(&caller).is_empty() == true,
            "You already have one piggy"
        );
        require!(
            lock_time > self.get_current_time(),
            "Lock time should be in the future!"
        );
        self.lock_time(&caller).set(&lock_time);
    }

    // addAmount endpoint (endpoint reference: https://docs.multiversx.com/developers/developer-reference/sc-annotations/#endpoint-and-view)
    #[endpoint(addAmount)]
    #[payable("EGLD")]
    fn add_amount(&self) {
        let payment = self.call_value().egld_value();
        // get smart contract caller address (reference: https://docs.multiversx.com/developers/developer-reference/sc-api-functions/#get_caller)
        let caller = &self.blockchain().get_caller();
        require!(
            self.lock_time(&caller).is_empty() == false,
            "You need to create your piggy bank first"
        );
        let sum = self.locked_amount(&caller).get();
        let amount = self.add(sum, payment.clone_value());
        self.locked_amount(&caller).set(amount);
    }

    // payOut endpoint (endpoint reference: https://docs.multiversx.com/developers/developer-reference/sc-annotations/#endpoint-and-view)
    #[endpoint(payOut)]
    fn pay_out(&self) {
        // get smart contract caller address (reference: https://docs.multiversx.com/developers/developer-reference/sc-api-functions/#get_caller)
        let caller = &self.blockchain().get_caller();
        require!(
            self.lock_time(&caller).get() < self.get_current_time(),
            "You can't withdraw your money yet"
        );
        require!(
            self.locked_amount(&caller).get() > 0,
            "There is nothing to withdraw"
        );

        // https://docs.multiversx.com/developers/transactions/tx-payment#egld-payment
        self.tx() // tx with sc environment
            .to(caller)
            .egld(&self.locked_amount(&caller).get())
            .transfer();

        self.locked_amount(&caller).clear();
        self.lock_time(&caller).clear();
    }

    fn get_current_time(&self) -> u64 {
        // get block timestamp (reference: https://docs.multiversx.com/developers/developer-reference/sc-api-functions/#get_block_timestamp)
        self.blockchain().get_block_timestamp()
    }

    fn add(&self, val1: BigUint, val2: BigUint) -> BigUint {
        val1 + val2
    }

    // getLockedAmount view (view reference: https://docs.multiversx.com/developers/developer-reference/sc-annotations/#endpoint-and-view)
    // lockedAmount storage mapper (storage reference: https://docs.multiversx.com/developers/developer-reference/sc-annotations/#storage)
    #[view(getLockedAmount)]
    #[storage_mapper("lockedAmount")]
    fn locked_amount(&self, piggy_owner: &ManagedAddress) -> SingleValueMapper<BigUint>;

    // getLockTime view (view reference: https://docs.multiversx.com/developers/developer-reference/sc-annotations/#endpoint-and-view)
    // lockedAmount storage mapper (storage reference: https://docs.multiversx.com/developers/developer-reference/sc-annotations/#storage)
    #[view(getLockTime)]
    #[storage_mapper("lockTime")]
    fn lock_time(&self, piggy_owner: &ManagedAddress) -> SingleValueMapper<u64>;
}
