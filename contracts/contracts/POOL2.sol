// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Pool2 is ERC20 {
    using SafeERC20 for IERC20;

    IERC20 public tokenA;
    IERC20 public tokenB;
    address public aiAddress;
    uint256 public constant FEE_RATE = 30; // 0.3%

    constructor(address _tokenA, address _tokenB, address _aiAddress) ERC20("Liquidity Provider Token 2", "LP_2") {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        aiAddress = _aiAddress;

        // Initial reserves
        tokenA.safeTransferFrom(msg.sender, address(this), 1000 * 10**decimals());
        tokenB.safeTransferFrom(msg.sender, address(this), 5000 * 10**decimals());
    }

    function swap(uint256 amountIn, address fromToken, address toToken) external {
        require(fromToken == address(tokenA) || fromToken == address(tokenB), "Invalid fromToken");
        require(toToken == address(tokenA) || toToken == address(tokenB), "Invalid toToken");

        // Transfer the amount from sender to pool
        IERC20(fromToken).safeTransferFrom(msg.sender, address(this), amountIn);

        uint256 amountOut = getAmountOut(amountIn, fromToken, toToken);

        // Take the fee and update reserves
        uint256 fee = (amountOut * FEE_RATE) / 10000;
        uint256 amountOutAfterFee = amountOut - fee;

        // Transfer the amount out to sender
        IERC20(toToken).safeTransfer(msg.sender, amountOutAfterFee);
    }

    function getAmountOut(uint256 amountIn, address fromToken, address toToken) public view returns (uint256) {
        uint256 reserveFrom = IERC20(fromToken).balanceOf(address(this));
        uint256 reserveTo = IERC20(toToken).balanceOf(address(this));
        uint256 amountInWithFee = amountIn * (10000 - FEE_RATE) / 10000;
        return (amountInWithFee * reserveTo) / (reserveFrom + amountInWithFee);
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external {
        tokenA.safeTransferFrom(msg.sender, address(this), amountA);
        tokenB.safeTransferFrom(msg.sender, address(this), amountB);
        _mint(msg.sender, amountA + amountB);
    }

    function removeLiquidity(uint256 liquidity) external {
        _burn(msg.sender, liquidity);
        uint256 amountA = (liquidity * tokenA.balanceOf(address(this))) / totalSupply();
        uint256 amountB = (liquidity * tokenB.balanceOf(address(this))) / totalSupply();
        tokenA.safeTransfer(msg.sender, amountA);
        tokenB.safeTransfer(msg.sender, amountB);
    }
}
