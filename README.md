## PiggyBank - MultiversX Smart Contract for learning purposes

The logic is quite simple:
1. You create a Piggy Bank where you define the lock time using Epoch Timestamp as the argument
2. You can send an amount of EGLD to the smart contract, and it will be locked till the configured date
3. You can then payout the amount, but only after the configured lock date

To interact with the PiggyBank Smart Contract, you would need to have:
- [wallet](https://devnet-wallet.multiversx.com)
- [mxpy](https://docs.multiversx.com/sdk-and-tools/sdk-py/installing-mxpy/) (can be also shipped with VS Code MultiversX IDE extension)
- PEM file derived from the seed phrase

You can get all with [VSCode MultiversX IDE extension](https://marketplace.visualstudio.com/items?itemName=Elrond.vscode-elrond-ide) 

To derive the wallet pem file, check the docs [Deriving the Wallet PEM file](https://docs.multiversx.com/sdk-and-tools/sdk-py/deriving-the-wallet-pem-file/)

**For simplicity, you can also deploy and interact using the dApp:** https://piggy-bank-dapp.netlify.app/

## How to prepare dev environment:

The simples way is to use VS Code MultiversX IDE extension through which you can configure Rust and mxpy.

Here are more resources on that topic:
- [Devcontainers](https://docs.multiversx.com/sdk-and-tools/devcontainers)
- [MultiversX docs tutorial](https://docs.multiversx.com/developers/tutorials/staking-contract/#prerequisites)
- [VSCode IDE extension walkthrough video](https://youtu.be/y0beoihLppA)

## Interaction with mxpy

Start with contract build

```
mxpy contract build
```

**Important** You would need some xEGLD on the devnet. You can use the faucet: [https://r3d4.fr/faucet](https://r3d4.fr/faucet). To get some xEGLD you can also use offcial Web Wallets (devnet/testnet) or there is also an option on official [Discord channel](https://discord.com/channels/1045353153073258557/1049254556216872990).

To use testnet switch to `--chain="T"` and --proxy="https://testnet-gateway.multiversx.com".

### mxpy interaction commands

We asume that the pem file is outside of the project directory. You can adjust the `--pem` path in each command. The smart contract address should be the one you'll get from deployment. Adjust the timestamp when creating a piggy bank (`--arguments <timestamp in future>`).

**Deploy the contract:**

```
mxpy --verbose contract deploy --chain="D" --bytecode="./output/piggybank.wasm" --pem="../walletKey.pem" --gas-limit=80000000 --proxy="https://devnet-gateway.multiversx.com" --recall-nonce --send
```

Smart Contract deployment. You will need to do this once.
In the example, the project name is `multiversx-simple-sc`, and the PEM file is located in `../walletKey.pem`.

**Create the Piggy:**
(here, with the working SC address example, change it, if you deployed yours, you should have one)

```
mxpy --verbose contract call erd1qqqqqqqqqqqqqpgqvqphdwsdtd6cnlt025kuu9hzjqhnexgu67es8lqc44 --chain="D" --pem="../walletKey.pem" --gas-limit=5000000 --function="createPiggy" --arguments 1655316103 --proxy="https://devnet-gateway.multiversx.com" --recall-nonce --send
```

As an argument for the `createPiggy` function, we will pass the timestamp for the lock time (it should be in the future, of course, use https://www.epochconverter.com/).

**Add amount:**
(here, with the working SC address example, change it, if you deployed yours, you should have one)

```
mxpy --verbose contract call erd1qqqqqqqqqqqqqpgqvqphdwsdtd6cnlt025kuu9hzjqhnexgu67es8lqc44 --chain="D" --pem="../walletKey.pem" --gas-limit=5000000 --function="addAmount" --value=1000000000000000000 --proxy="https://devnet-gateway.multiversx.com" --recall-nonce --send
```

We are adding one xEGLD (denomination 18, this is why it is, in fact, 1000000000000000000).

**Payout:**
(here, with the working SC address example, change it, if you deployed yours, you should have one)

```
mxpy --verbose contract call erd1qqqqqqqqqqqqqpgqvqphdwsdtd6cnlt025kuu9hzjqhnexgu67es8lqc44 --chain="D" --pem="../walletKey.pem" --gas-limit=5000000 --function="payOut" --proxy="https://devnet-gateway.multiversx.com" --recall-nonce --send
```

It will check if you can withdraw. It will compare lock time and the current block timestamp. 

**Upgrade the contract:**
(here, with the working SC address example, change it, if you deployed yours, you should have one)
 
```
mxpy --verbose contract upgrade erd1qqqqqqqqqqqqqpgqvqphdwsdtd6cnlt025kuu9hzjqhnexgu67es8lqc44 --chain="D" --bytecode="./output/piggybank.wasm" --pem="../walletKey.pem" --gas-limit=20000000 --proxy="https://devnet-gateway.multiversx.com" --recall-nonce --send
```

## Testing

Tests are based on [blackbox testing](https://docs.multiversx.com/developers/testing/rust/sc-blackbox-calls) approach.
You will find tests in `tests/piggybank_rust_test.rs`. 
To run a test, you can click on the `Run Test` button from under the test name in VS Code.
You can also run it with `cargo test --test piggybank_rust_test`.
Or you can use `sc-meta` tool: `sc-meta test`.

## Development
Besides cloning the repository, you can also use buildo-begins CLI:
- `npx buildo-begins@latest init` - from the list, choose Piggy Bank smart contract. You can also initialize the dapp for interactions.
