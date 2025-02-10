// eslint-disable-next-line no-undef
const BURN = artifacts.require("BURN");

module.exports = async (deployer) => {
  const initialSupply = 100000; // Initial supply of 100,000 BURN
  await deployer.deploy(BURN, initialSupply);
};
