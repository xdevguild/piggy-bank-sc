USER_PEM="../walletKey.pem"
PROXY="https://devnet-gateway.multiversx.com"
CHAIN_ID="D"
BYTECODE_PATH="./output/piggybank.wasm"

SC_ADDRESS=$(mxpy data load --key=address-devnet)

## Example values:
# LOCK_EPOCH_TIMESTAMP=1734501286
# AMOUNT_TO_LOCK=1000000000000000000

deploy() {
    mxpy --verbose contract deploy --chain=${CHAIN_ID} --bytecode=${BYTECODE_PATH} --pem=${USER_PEM} --gas-limit=20000000 --proxy=${PROXY} --recall-nonce --outfile="deploy-devnet.interaction.json" --send

    SC_ADDRESS=$(mxpy data parse --file="deploy-devnet.interaction.json" --expression="data['contractAddress']")
    mxpy data store --key=address-devnet --value=${SC_ADDRESS}

    echo ""
    echo "Smart contract address: ${SC_ADDRESS}"
}

createPiggy() {
    read -p "LOCK_EPOCH_TIMESTAMP: Enter date in future using Unix Epoch timestamp: " LOCK_EPOCH_TIMESTAMP
    mxpy --verbose contract call ${SC_ADDRESS} --function="createPiggy" --chain=${CHAIN_ID} --pem=${USER_PEM} --gas-limit=2000000 --proxy=${PROXY} --recall-nonce --arguments ${LOCK_EPOCH_TIMESTAMP} --send
}

addAmount() {
    read -p "AMOUNT_TO_LOCK: Enter amount to lock in EGLD (1 = 1000000000000000000): " AMOUNT_TO_LOCK
    mxpy --verbose contract call ${SC_ADDRESS} --function="addAmount" --chain=${CHAIN_ID} --pem=${USER_PEM} --gas-limit=2000000 --proxy=${PROXY} --recall-nonce --value=${AMOUNT_TO_LOCK} --send
}

payOut() {
    mxpy --verbose contract call ${SC_ADDRESS} --function="payOut" --chain=${CHAIN_ID} --pem=${USER_PEM} --gas-limit=2000000 --proxy=${PROXY} --recall-nonce  --send
}

upgrade() {
  mxpy --verbose contract upgrade ${SC_ADDRESS} --bytecode=${BYTECODE_PATH} --chain=${CHAIN_ID} --pem=${USER_PEM} --gas-limit=2000000 --proxy=${PROXY} --recall-nonce --send
}
