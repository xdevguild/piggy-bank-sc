### PiggyBank

To interact with the PiggyBank Smart Contract, you would need to have [erdpy](https://docs.elrond.com/sdk-and-tools/erdpy/installing-erdpy/)

To derive the wallet pem file, check the docs [Deriving the Wallet PEM file](https://docs.elrond.com/sdk-and-tools/erdpy/deriving-the-wallet-pem-file/)

### Blog post

- [Smart Contract for Elrond and Arwen](https://www.julian.io/articles/elrond-smart-contracts.html)

### Walkthrough videos

- [Elrond Smart Contracts - interacting using erdpy](https://youtu.be/mIsNI7ZxQRM)
- [Elrond Smart Contracts - interacting using simple front-end app](https://youtu.be/Sjpj7Btasgs)

### Frontend App

- [FE App repo](https://github.com/juliancwirko/elrond-simple-sc-frontend-app)
- [https://elven-piggy-bank.netlify.app/](https://elven-piggy-bank.netlify.app/)

### Start with contract build**

```
erdpy contract build
```

**Important** You would need some xEGLD on the testnet. There is one faucet which you can use: [https://r3d4.fr/elrond/testnet/](https://r3d4.fr/elrond/testnet/). **Sometimes it won't be able to send a lot of xEGLD**. **You can also use devnet**, where you should be able to use a web wallet's built-in faucet.

To use devnet switch to `--chain="D"`.

### Example erdpy interaction commands

**Deploy the contract:**

```
erdpy --verbose contract deploy --chain="T" --project=piggybank --pem="wallets/test.pem" --gas-limit=80000000 --proxy="https://testnet-gateway.elrond.com" --recall-nonce --send
```

Smart Contract deployment. You will need to do this once.
The project name is `piggybank,` and the pem file is located in `wallets/test.pem`.

**Upgrade the contract:**
 
```
erdpy --verbose contract upgrade {smart_contract_address_here} --chain="T" --project=piggybank --pem="wallets/test.pem" --gas-limit=80000000 --proxy="https://testnet-gateway.elrond.com" --recall-nonce --send
```

If there are changes in the contract, you can upgrade it.

**Create the Piggy:**

```
erdpy --verbose contract call {smart_contract_address_here} --chain="T" --pem="wallets/test.pem" --gas-limit=5000000 --function="create_piggy" --arguments 1628619457 --proxy="https://testnet-gateway.elrond.com" --recall-nonce --send
```

As an argument for the `create_piggy` function, we will pass the timestamp for the lock time (should be in the future of course).

**Add amount:**

```
erdpy --verbose contract call {smart_contract_address_here} --chain="T" --pem="wallets/test.pem" --gas-limit=5000000 --function="add_amount" --value=1000000000000000000 --proxy="https://testnet-gateway.elrond.com" --recall-nonce --send
```

We are adding one xEGLD (denomination 18, this is why it is, in fact, 1000000000000000000).

**Get amount:**

```
erdpy --verbose contract call {smart_contract_address_here} --chain="T" --pem="wallets/test.pem" --gas-limit=5000000 --function="amount" --proxy="https://testnet-gateway.elrond.com" --recall-nonce --send
```

**Payout:**

```
erdpy --verbose contract call {smart_contract_address_here} --chain="T" --pem="wallets/test.pem" --gas-limit=5000000 --function="pay_out" --proxy="https://testnet-gateway.elrond.com" --recall-nonce --send
```

It will check if you can withdraw. It will compare lock time and the current block timestamp. 
