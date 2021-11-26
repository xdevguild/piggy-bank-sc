#![no_std]

elrond_wasm::imports!();

#[elrond_wasm::contract]
pub trait PiggyBank {
  fn get_current_time(&self) -> u64 {
    self.blockchain().get_block_timestamp()
  }

  fn add(&self, val1: BigUint, val2: BigUint) -> BigUint {
    val1 + val2
  }

  #[init]
  fn init(&self) -> SCResult<()> {
    let my_address = &self.blockchain().get_caller();
    self.owner().set(&my_address.to_address());
    Ok(())
  }

  #[endpoint(createPiggy)]
  fn create_piggy(&self, lock_time: u64) -> SCResult<()> {
    let caller = &self.blockchain().get_caller();
    let caller_address = caller.to_address();
    require!(
      self.lock_time(&caller_address).is_empty() == true,
      "You already have one piggy"
    );
    require!(
      lock_time > self.get_current_time(),
      "Lock time should be in the future!"
    );
    self.lock_time(&caller_address).set(&lock_time);
    Ok(())
  }

  #[endpoint(addAmount)]
  #[payable("EGLD")]
  fn add_amount(&self, #[payment] payment: BigUint) -> SCResult<()> {
    let caller = &self.blockchain().get_caller();
    let caller_address = caller.to_address();
    require!(
      self.lock_time(&caller_address).is_empty() == false,
      "You need to create your piggy bank first"
    );
    let sum = self.locked_amount(&caller_address).get();
    let amount = self.add(sum, payment);
    self.locked_amount(&caller_address).set(&amount);
    Ok(())
  }

  #[endpoint(payOut)]
  fn pay_out(&self) -> SCResult<()> {
    let caller = &self.blockchain().get_caller();
    let caller_address = caller.to_address();
    require!(
      self.lock_time(&caller_address).get() < self.get_current_time(),
      "You can't withdraw your money yet"
    );
    require!(self.locked_amount(&caller_address).get() > 0, "There is nothing to withdraw");
    self.send()
      .direct_egld(caller, &self.locked_amount(&caller_address).get(), &[]);

    self.locked_amount(&caller_address).clear();
    self.lock_time(&caller_address).clear();

    Ok(())
  }

  #[storage_mapper("owner")]
  fn owner(&self) -> SingleValueMapper<Address>;

  #[view(getLockedAmount)]
  #[storage_mapper("lockedAmount")]
  fn locked_amount(&self, piggy_owner: &Address) -> SingleValueMapper<BigUint>;

  #[view(getLockTime)]
  #[storage_mapper("lockTime")]
  fn lock_time(&self, piggy_owner: &Address) -> SingleValueMapper<u64>;
}
