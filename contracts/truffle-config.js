require("dotenv").config();
const HDWalletProvider = require("@truffle/hdwallet-provider");

module.exports = {
  networks: {
    // Base Testnet Configuration
    abcTestnet: {
      provider: () =>
        new HDWalletProvider(
          process.env.MNEMONIC, // Your wallet's mnemonic
          "https://sepolia.base.org" // RPC URL for Base Testnet
        ),
      network_id: 84532, // Network ID for Base Testnet
      gas: 8000000, // Gas limit
      gasPrice: 1000000000, // Gas price (1 Gwei)
      timeoutBlocks: 200, // Increase timeout for deployment
      skipDryRun: true, // Skip dry run before migrations
    },
  },

  // Compiler settings
  compilers: {
    solc: {
      version: "0.8.20", // Specify the Solidity compiler version
      settings: {
        optimizer: {
          enabled: true,
          runs: 200, // Optimize for gas usage
        },
      },
    },
  },
};
