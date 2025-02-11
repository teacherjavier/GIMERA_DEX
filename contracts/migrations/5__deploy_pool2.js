const Pool2 = artifacts.require("Pool2");

module.exports = function (deployer, network, accounts) {
  const tokenAAddress = "CRASH_TOKEN_ADDRESS"; // Replace with actual address
  const tokenBAddress = "BURN_TOKEN_ADDRESS"; // Replace with actual address
  const lpTokenAddress = "LP_2_TOKEN_ADDRESS"; // Replace with actual address
  const aiAddress = "AI_WALLET_ADDRESS"; // Replace with actual address

  deployer.deploy(
    Pool2,
    tokenAAddress,
    tokenBAddress,
    lpTokenAddress,
    aiAddress
  );
};
