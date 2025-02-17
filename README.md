# FundMe Smart Contract

⚠️ **WARNING**: This is sample code provided for educational purposes only. Use at your own risk. The creator and contributors are not responsible for any issues, losses, or damages that may result from using this code. Always conduct a thorough security audit before deploying any smart contract to a production environment.

### Disclaimer

- This code has not been audited by security professionals.
- Smart contracts inherently carry financial risks.
- The code may contain bugs or vulnerabilities.
- Always test thoroughly on test networks before any mainnet deployment.
- This code does not guarantee any financial returns or safety of funds.
- The creator disclaims all liability for any loss of funds resulting from the use of this code.

## Overview

The FundMe contract is a crowdfunding smart contract built on Ethereum that allows users to:

- Fund the contract with ETH (with a minimum USD value requirement)
- Only the contract owner can withdraw the funds
- Uses Chainlink Price Feeds to convert ETH to USD value in real-time

## Contract Features

### Main Functionality:
- **fund()**: Allows users to send ETH to the contract (minimum $5 USD equivalent)
- **withdraw()**: Allows only the owner to withdraw all funds (standard implementation)
- **cheaperWithdraw()**: Gas-optimized withdrawal function
- **fallback() & receive()**: Automatically calls fund() when ETH is sent directly to the contract

### View Functions:
- **getAddressToAmountFunded()**: Check how much a specific address has funded
- **getFunder()**: Get the address of a funder by index
- **getOwner()**: Get the contract owner's address
- **getVersion()**: Get the Chainlink Price Feed version

## Development with Foundry

This project uses [Foundry](https://book.getfoundry.sh/), a modern Ethereum development environment written in Rust.

### Getting Started

1. Install Foundry:
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

2. Clone this repository:
```bash
git clone <repository-url>
cd <repository-name>
```

3. Install dependencies:
```bash
forge install
```

### Build & Test

```bash
# Compile the contracts
forge build

# Run the tests
forge test

# Run a specific test
forge test --match-test testFunctionName

# Run tests with gas reporting
forge test --gas-report
```

### Deployment

To deploy to a network:

```bash
forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
```

Replace `<your_rpc_url>` and `<your_private_key>` with your actual values.

⚠️ **CAUTION**: Never hardcode or commit your private keys. Use environment variables or a secure secret management system.

### Interacting with the Contract

Using Cast (Foundry's command-line tool):

```bash
# Fund the contract (send 0.1 ETH)
cast send <contract_address> "fund()" --value 0.1ether --rpc-url <your_rpc_url> --private-key <your_private_key>

# Check funding amount for a specific address
cast call <contract_address> "getAddressToAmountFunded(address)" <address_to_check> --rpc-url <your_rpc_url>

# Withdraw (only works if you're the owner)
cast send <contract_address> "withdraw()" --rpc-url <your_rpc_url> --private-key <your_private_key>
```

## Advanced Configuration

### Chainlink Price Feeds

The contract is designed to work with different networks by accepting a Price Feed address in the constructor. When deploying, you'll need to provide the appropriate Chainlink Price Feed address for your target network.

Common ETH/USD Price Feed addresses:
- Sepolia: `0x694AA1769357215DE4FAC081bf1f309aDC325306`
- Mainnet: `0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419`

⚠️ **WARNING**: Always verify Price Feed addresses before deployment. Incorrect addresses can result in faulty price calculations and potential loss of funds.

### Forge Configuration

This project uses remappings for dependencies. These are configured in `foundry.toml`:

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
remappings = [
    "@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts/",
]
```

## Security Considerations

- This contract interacts with external price feeds which could potentially be manipulated.
- The contract owner has complete control over the funds and can withdraw them at any time.
- There is no mechanism for refunds once funds are sent.
- Price fluctuations could affect the minimum USD requirement.
- No formal verification or audit has been conducted on this code.

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

⚠️ **FINAL WARNING**: This code is experimental and unaudited. Do not use it to manage real funds without proper security reviews and audits. The creator is not liable for any losses incurred through the use of this code.