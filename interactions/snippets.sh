USER_PEM="../walletKey.pem"
PROXY="https://devnet-gateway.multiversx.com"
CHAIN_ID="D"

SC_ADDRESS=erd1qqqqqqqqqqqqqpgqz2q2m9u8jgtejcvlax20a6na8xa0ux04vafslfpfx8
LOCK_EPOCH_TIMESTAMP=1675690008
AMOUNT_TO_LOCK=1000000000000000000

deploy() {
    mxpy --verbose contract deploy --project=${PROJECT} \
    --recall-nonce --pem=${USER_PEM} \
    --gas-limit=2000000 \
    --send --outfile="deploy-devnet.interaction.json" \
    --proxy=${PROXY} --chain=${CHAIN_ID} || return
}

createPiggy() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=2000000 \
    --arguments ${LOCK_EPOCH_TIMESTAMP} \
    --function="createPiggy"
}

addAmount() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=2000000 \
    --value=${AMOUNT_TO_LOCK} \
    --function="addAmount" 
}

payOut() {
    mxpy --verbose contract call ${SC_ADDRESS} \
    --proxy=${PROXY} --chain=${CHAIN_ID} \
    --send --recall-nonce --pem=${USER_PEM} \
    --gas-limit=2000000 \
    --function="payOut"
}

upgrade() {
  mxpy --verbose contract upgrade ${SC_ADDRESS} \
    --project=${PROJECT} \
    --recall-nonce --pem=${USER_PEM} \
    --gas-limit=2000000 \
    --send --outfile="upgrade-devnet.interaction.json" \
    --proxy=${PROXY} --chain=${CHAIN_ID} || return
}
