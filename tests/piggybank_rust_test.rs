use multiversx_sc_scenario::imports::*;

use piggybank::*;

// new types
const OWNER_ADDRESS: TestAddress = TestAddress::new("owner");
const USER_ADDRESS: TestAddress = TestAddress::new("user");
const PIGGYBANK_ADDRESS: TestSCAddress = TestSCAddress::new("piggybank");
const CODE_PATH: MxscPath = MxscPath::new("output/piggybank.mxsc.json");
const LOCK_TIMESTAMP: u64 = 4115200247u64;

fn world() -> ScenarioWorld {
    let mut blockchain = ScenarioWorld::new();

    blockchain.register_contract(CODE_PATH, piggybank::ContractBuilder);
    blockchain
}

#[test]
fn piggybank_blackbox() {
    let mut world = world(); // ScenarioWorld

    // starting mandos trace
    world.start_trace();

    // set states for owners
    world.account(OWNER_ADDRESS).nonce(1).balance(100);
    world.account(USER_ADDRESS).nonce(1).balance(100);

    // deploy the contract
    let new_address = world
        .tx() // tx with test environment
        .from(OWNER_ADDRESS)
        .typed(piggybank_proxy::PiggyBankProxy) // typed call - proxy
        .init() // deploy call
        .code(CODE_PATH)
        .new_address(PIGGYBANK_ADDRESS) // custom deploy address for tests
        .returns(ReturnsNewAddress) // returns new address after deploy
        .run(); // send transaction

    assert_eq!(new_address, PIGGYBANK_ADDRESS.to_address());

    world
        .tx() // tx with sc environment
        .from(OWNER_ADDRESS)
        .to(PIGGYBANK_ADDRESS)
        .typed(piggybank_proxy::PiggyBankProxy)
        .create_piggy(LOCK_TIMESTAMP)
        .run();

    world
        .tx() // tx with sc environment
        .from(OWNER_ADDRESS)
        .to(PIGGYBANK_ADDRESS)
        .typed(piggybank_proxy::PiggyBankProxy)
        .add_amount()
        .egld(BigUint::from(10u32))
        .run();

    world
        .query()
        .to(PIGGYBANK_ADDRESS)
        .typed(piggybank_proxy::PiggyBankProxy)
        .lock_time(OWNER_ADDRESS)
        .returns(ExpectValue(LOCK_TIMESTAMP))
        .run();

    world
        .query()
        .to(PIGGYBANK_ADDRESS)
        .typed(piggybank_proxy::PiggyBankProxy)
        .locked_amount(OWNER_ADDRESS)
        .returns(ExpectValue(BigUint::from(10u32)))
        .run();

    world.check_account(OWNER_ADDRESS).balance(90);
    world.check_account(PIGGYBANK_ADDRESS).balance(10);

    world
        .tx() // tx with sc environment
        .from(OWNER_ADDRESS)
        .to(PIGGYBANK_ADDRESS)
        .typed(piggybank_proxy::PiggyBankProxy)
        .pay_out()
        .returns(ExpectError(4, "You can't withdraw your money yet"))
        .run();

    // Create another piggy for a new user
    world
        .tx() // tx with sc environment
        .from(USER_ADDRESS)
        .to(PIGGYBANK_ADDRESS)
        .typed(piggybank_proxy::PiggyBankProxy)
        .create_piggy(LOCK_TIMESTAMP)
        .run();

    world
        .tx() // tx with sc environment
        .from(USER_ADDRESS)
        .to(PIGGYBANK_ADDRESS)
        .typed(piggybank_proxy::PiggyBankProxy)
        .add_amount()
        .egld(BigUint::from(20u32))
        .run();

    world.check_account(USER_ADDRESS).balance(80);
    world.check_account(PIGGYBANK_ADDRESS).balance(30);

    world.write_scenario_trace("tests/piggybank.scen.json");
}
