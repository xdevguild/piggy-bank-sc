USER_PEM="../walletKey.pem"
PROXY="https://devnet-gateway.elrond.com"
CHAIN_ID="D"

SC_ADDRESS=erd1qqqqqqqqqqqqqpgqz22zn8njz6649aazgqwnspefekcd3pkrvafs4x732r
LOCK_EPOCH_TIMESTAMP=1675690008
AMOUNT_TO_LOCK=1000000000000000000

deploy() {
    erdpy --verbose contract deploy --project=${PROJECT} \
    --recall-nonce --pem=${USER_PEM} \
    --gas-limit=10000000 \
    --send --outfile="deploy-devnet.interaction.json" \
    --proxy=${PROXY} --chain=${CHAIN_ID} || return
}

createPiggy() {
    erdpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=5000000 \
    --arguments ${LOCK_EPOCH_TIMESTAMP} \
    --function="createPiggy"
}

addAmount() {
    erdpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=5000000 \
    --value=${AMOUNT_TO_LOCK} \
    --function="addAmount" 
}

payOut() {
    erdpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=5000000 \
    --function="payOut"
}

upgrade() {
  erdpy --verbose contract upgrade ${SC_ADDRESS} \
    --project=${PROJECT} \
    --recall-nonce --pem=${USER_PEM} \
    --gas-limit=20000000 \
    --send --outfile="upgrade-devnet.interaction.json" \
    --proxy=${PROXY} --chain=${CHAIN_ID} || return
}
