### PiggyBank - Elrond Smart Contract for learning purposes

> **⚠ Proper docs, updates, tests, and dapp are on the way! Stay tuned.**

While waiting for proper tutorials and docs, you can test it and play with it even now.

To interact with the PiggyBank Smart Contract, you would need to have:
- [wallet](https://devnet-wallet.elrond.com)
- [erdpy](https://docs.elrond.com/sdk-and-tools/erdpy/installing-erdpy/)
- PEM file derived from the seed phrase

To derive the wallet pem file, check the docs [Deriving the Wallet PEM file](https://docs.elrond.com/sdk-and-tools/erdpy/deriving-the-wallet-pem-file/)

### The article on how to prepare dev environment:
- [Linux environment for development](https://elrond-dev-guild.gitbook.io/scrolls/readme/linux-environment-for-development)

### Old dapp (it will be rewritten soon)
- https://elven-piggy-bank.netlify.app

### Start with contract build**

```
erdpy contract build
```

**Important** You would need some xEGLD on the devnet. You can use the faucet: [https://r3d4.fr/elrond/devnet/](https://r3d4.fr/elrond/devnet/).

To use testnet switch to `--chain="T"` and --proxy="https://testnet-gateway.elrond.com".

### Example erdpy interaction commands
##### These commands should be run one folder up from the cloned 'elrond-simple-sc' folder

**Deploy the contract:**

```
erdpy --verbose contract deploy --chain="D" --project=elrond-simple-sc --pem="elrond-simple-sc/wallets/test.pem" --gas-limit=80000000 --proxy="https://devnet-gateway.elrond.com" --recall-nonce --send
```

Smart Contract deployment. You will need to do this once.
In the example, the project name is `elrond-simple-sc`, and the pem file is located in `wallets/test.pem`.

**Upgrade the contract:**
(here, with the working SC address example, change it, if you deployed yours, you should have one)
 
```
erdpy --verbose contract upgrade erd1qqqqqqqqqqqqqpgq9xrwp7qnfamenqsxpwsf84x9e9sx8vxhgtksusvhgs --chain="D" --project=elrond-simple-sc --pem="elrond-simple-sc/wallets/test.pem" --gas-limit=80000000 --proxy="https://devnet-gateway.elrond.com" --recall-nonce --send
```

**Create the Piggy:**
(here, with the working SC address example, change it, if you deployed yours, you should have one)

```
erdpy --verbose contract call erd1qqqqqqqqqqqqqpgq9xrwp7qnfamenqsxpwsf84x9e9sx8vxhgtksusvhgs --chain="D" --pem="elrond-simple-sc/wallets/test.pem" --gas-limit=5000000 --function="createPiggy" --arguments 1655316103 --proxy="https://devnet-gateway.elrond.com" --recall-nonce --send
```

As an argument for the `createPiggy` function, we will pass the timestamp for the lock time (it should be in the future, of course, use https://www.epochconverter.com/).

**Add amount:**
(here, with the working SC address example, change it, if you deployed yours, you should have one)

```
erdpy --verbose contract call erd1qqqqqqqqqqqqqpgq9xrwp7qnfamenqsxpwsf84x9e9sx8vxhgtksusvhgs --chain="D" --pem="elrond-simple-sc/wallets/test.pem" --gas-limit=5000000 --function="addAmount" --value=1000000000000000000 --proxy="https://devnet-gateway.elrond.com" --recall-nonce --send
```

We are adding one xEGLD (denomination 18, this is why it is, in fact, 1000000000000000000).

**Payout:**
(here, with the working SC address example, change it, if you deployed yours, you should have one)

```
erdpy --verbose contract call erd1qqqqqqqqqqqqqpgq9xrwp7qnfamenqsxpwsf84x9e9sx8vxhgtksusvhgs --chain="D" --pem="elrond-simple-sc/wallets/test.pem" --gas-limit=5000000 --function="payOut" --proxy="https://devnet-gateway.elrond.com" --recall-nonce --send
```

It will check if you can withdraw. It will compare lock time and the current block timestamp. 

Proper docs for the beginners soon!
