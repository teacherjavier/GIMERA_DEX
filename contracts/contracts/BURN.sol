// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BURN is ERC20 {
    constructor(uint256 initialSupply) ERC20("BURN Token", "BURN") {
        _mint(msg.sender, initialSupply * 10**decimals());
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount * 10**decimals());
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount * 10**decimals());
    }
}
