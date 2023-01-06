use elrond_wasm::types::Address;
use elrond_wasm_debug::{
    managed_address, managed_biguint, rust_biguint, testing_framework::*, DebugApi,
};
use piggybank::*;

const WASM_PATH: &'static str = "output/piggybank.wasm";
const USER_BALANCE: u64 = 1_000_000_000_000_000_000;

struct ContractSetup<ContractObjBuilder>
where
    ContractObjBuilder: 'static + Copy + Fn() -> piggybank::ContractObj<DebugApi>,
{
    pub b_mock: BlockchainStateWrapper,
    pub user_address: Address,
    pub contract_wrapper: ContractObjWrapper<piggybank::ContractObj<DebugApi>, ContractObjBuilder>,
}

impl<ContractObjBuilder> ContractSetup<ContractObjBuilder>
where
    ContractObjBuilder: 'static + Copy + Fn() -> piggybank::ContractObj<DebugApi>,
{
    pub fn new(sc_builder: ContractObjBuilder) -> Self {
        let rust_zero = rust_biguint!(0u64);
        let mut b_mock = BlockchainStateWrapper::new();
        let owner_address = b_mock.create_user_account(&rust_zero);
        let user_address = b_mock.create_user_account(&rust_biguint!(USER_BALANCE));
        let sc_wrapper =
            b_mock.create_sc_account(&rust_zero, Some(&owner_address), sc_builder, WASM_PATH);

        // simulate deploy
        b_mock
            .execute_tx(&owner_address, &sc_wrapper, &rust_zero, |sc| {
                sc.init();
            })
            .assert_ok();

        ContractSetup {
            b_mock,
            user_address,
            contract_wrapper: sc_wrapper,
        }
    }
}

#[test]
fn create_piggy_test() {
    let mut setup = ContractSetup::new(piggybank::contract_obj);
    let user_addr = setup.user_address.clone();

    setup
        .b_mock
        .execute_tx(
            &user_addr,
            &setup.contract_wrapper,
            &rust_biguint!(0u64),
            |sc| {
                sc.create_piggy(1675690008u64);

                assert_eq!(
                    sc.lock_time(&managed_address!(&user_addr)).get(),
                    1675690008u64
                );
            },
        )
        .assert_ok();
}

#[test]
fn add_amount_test() {
    let mut setup = ContractSetup::new(piggybank::contract_obj);
    let user_addr = setup.user_address.clone();

    setup
        .b_mock
        .execute_tx(
            &user_addr,
            &setup.contract_wrapper,
            &rust_biguint!(USER_BALANCE),
            |sc| {
                sc.lock_time(&managed_address!(&user_addr))
                    .set(1675690008u64);

                sc.add_amount();

                assert_eq!(
                    sc.locked_amount(&managed_address!(&user_addr)).get(),
                    managed_biguint!(USER_BALANCE)
                );
            },
        )
        .assert_ok();

    setup
        .b_mock
        .check_egld_balance(&user_addr, &rust_biguint!(0));
}

#[test]
fn payout_test() {
    let mut setup = ContractSetup::new(piggybank::contract_obj);
    let user_addr = setup.user_address.clone();

    setup.b_mock.set_block_timestamp(1675690008u64);

    setup
        .b_mock
        .execute_tx(
            &user_addr,
            &setup.contract_wrapper,
            &rust_biguint!(USER_BALANCE),
            |sc| {
                sc.lock_time(&managed_address!(&user_addr))
                    .set(1673016426u64);

                sc.locked_amount(&managed_address!(&user_addr))
                    .set(managed_biguint!(USER_BALANCE));

                sc.pay_out();

                assert_eq!(
                    sc.locked_amount(&managed_address!(&user_addr)).get(),
                    managed_biguint!(0u64)
                );

                assert_eq!(sc.lock_time(&managed_address!(&user_addr)).get(), 0u64);
            },
        )
        .assert_ok();

    setup
        .b_mock
        .check_egld_balance(&user_addr, &rust_biguint!(USER_BALANCE));
}
