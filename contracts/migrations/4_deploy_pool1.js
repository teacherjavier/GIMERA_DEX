const Pool1 = artifacts.require("Pool1");

module.exports = function (deployer, network, accounts) {
  const tokenAAddress = "CRASH_TOKEN_ADDRESS"; // Replace with actual address
  const tokenBAddress = "BURN_TOKEN_ADDRESS"; // Replace with actual address
  const lpTokenAddress = "LP_1_TOKEN_ADDRESS"; // Replace with actual address
  const aiAddress = "AI_WALLET_ADDRESS"; // Replace with actual address

  deployer.deploy(
    Pool1,
    tokenAAddress,
    tokenBAddress,
    lpTokenAddress,
    aiAddress
  );
};
