// eslint-disable-next-line no-undef
const CRASH = artifacts.require("CRASH");

module.exports = async (deployer) => {
  const initialSupply = 100000; // Initial supply of 100,000 CRASH
  await deployer.deploy(CRASH, initialSupply);
};
