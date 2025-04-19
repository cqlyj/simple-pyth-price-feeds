# Simple Pyth Price Feed Demo

This is a simple demo of how to use the Pyth price feed in Solidity.

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.3.0 (5a8bd89 2024-12-19T17:17:10.245193696Z)`

## Quickstart

```
git clone https://github.com/cqlyj/simple-pyth-price-feeds
cd simple-pyth-price-feeds
make
```

# Usage

1. Set up your environment variables and fill in the `.env` file with your own values.

```bash
cp .env.example .env
```

2. Deploy the `PythPriceFeed` contract:

```bash
make deploy
```

3. Send a few eth to the contract by grabbing the address from the `deploy` output and sending some from your wallet.

4. Get the `priceUpdate` data:

```bash
make get-price-update
```

5. Then copy the data field from the `price_update.json` file and paste it into the script `GetETHUSDPrice.s.sol`:

```bash
  priceUpdate[
            0
        ] = "0x..."; // paste the data here, note that the data should start with 0x
```

6. Run the script to get the price:

```bash
make get-eth-usd-price
```

## NOTE

If you failed to run the script and get custom error `0x6ce2251a`, then just go to the explorer and send transaction there. You can find more information here: [Custom error 0x6ce2251a](https://dev-forum.pyth.network/t/custom-error-0x6ce2251a/54/1).

# Test

You can run the tests with the following command:

```bash
forge test -vvvv
```

## Contact

Luo Yingjie - [luoyingjie0721@gmail.com](luoyingjie0721@gmail.com)
