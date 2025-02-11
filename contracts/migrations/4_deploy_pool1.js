const Pool1 = artifacts.require("Pool1");
const TokenA = artifacts.require("CRASH");
const TokenB = artifacts.require("BURN");

module.exports = async function (deployer) {
  const tokenAInstance = await TokenA.deployed();
  const tokenBInstance = await TokenB.deployed();
  const aiAddress = "your-ai-address-here"; // Replace with actual AI address
  await deployer.deploy(
    Pool1,
    tokenAInstance.address,
    tokenBInstance.address,
    aiAddress
  );
};
