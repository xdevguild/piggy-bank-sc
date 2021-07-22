#![no_std]

elrond_wasm::imports!();
elrond_wasm::derive_imports!();

#[elrond_wasm_derive::contract]
pub trait PiggyBank {
	fn get_current_time(&self) -> u64 {
		self.blockchain().get_block_timestamp()
	}

	fn add(&self, val1: Self::BigUint, val2: Self::BigUint) -> Self::BigUint {
		val1 + val2
	}

	#[storage_set("owner")]
    fn set_owner(&self, address: &Address);
    #[storage_get("owner")]
    fn get_owner(&self) -> Address;

	#[storage_set("amount")]
	fn set_amount(&self, piggy_owner: &Address, sum: Self::BigUint);

	#[storage_get("amount")]
	fn get_amount(&self, piggy_owner: &Address) -> Self::BigUint;

	#[storage_set("lock_time")]
    fn set_lock_time(&self, piggy_owner: &Address, lock_time: u64);
    #[storage_get("lock_time")]
    fn get_lock_time(&self, piggy_owner: &Address) -> u64;
	#[storage_is_empty("lock_time")]
	fn is_lock_time_empty(&self, piggy_owner: &Address) -> bool;

	#[init]
	fn init(&self) -> SCResult<()> {
		let my_address: Address = self.blockchain().get_caller();
		self.set_owner(&my_address);
		Ok(())
	}

	#[endpoint]
	fn amount(&self) -> SCResult<Self::BigUint> {
		let caller = self.blockchain().get_caller();
		require!(self.is_lock_time_empty(&caller) == false, "You need to create your piggy bank first");
		Ok(self.get_amount(&caller))
	}

	#[endpoint]
	fn create_piggy(&self, lock_time: u64) -> SCResult<()> {
		let caller = self.blockchain().get_caller();
		require!(self.is_lock_time_empty(&caller) == true, "You already have one piggy");
		require!(lock_time > self.get_current_time(), "Lock time shouldn't be set for now");
		self.set_lock_time(&caller, lock_time);
		Ok(())
	}

    #[endpoint]
	#[payable("EGLD")]
	fn add_amount(&self, #[payment] payment: Self::BigUint) -> SCResult<()> {
		let caller = self.blockchain().get_caller();
		require!(self.is_lock_time_empty(&caller) == false, "You need to create your piggy bank first");
		let sum = self.get_amount(&caller);
		let amount = self.add(sum, payment);
		self.set_amount(&caller, amount);
		Ok(())
	}

	#[endpoint]
	fn pay_out(&self) -> SCResult<()> {
		let caller = self.blockchain().get_caller();
		require!(self.get_lock_time(&caller) < self.get_current_time(), "You can't withdraw your money yet");
		require!(self.get_amount(&caller) > 0, "There is nothing to withdraw");
		self.send().direct_egld(&caller, &self.get_amount(&caller), &[]);
		Ok(())
	}
}
