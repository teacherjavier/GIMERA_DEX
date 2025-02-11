// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Pool1 is Ownable {
    IERC20 public tokenA;
    IERC20 public tokenB;
    IERC20 public lpToken;
    address public aiAddress;

    uint256 public reserveA;
    uint256 public reserveB;

    uint256 public constant FEE_PERCENTAGE = 3; // 0.3%
    uint256 public constant FEE_DENOMINATOR = 1000;

    constructor(
        address _tokenA,
        address _tokenB,
        address _lpToken,
        address _aiAddress
    ) Ownable(msg.sender) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        lpToken = IERC20(_lpToken);
        aiAddress = _aiAddress;

        reserveA = 2000 * 10**18;
        reserveB = 1000 * 10**18;

        tokenA.transferFrom(msg.sender, address(this), reserveA);
        tokenB.transferFrom(msg.sender, address(this), reserveB);
    }

    modifier onlyAIorUser(address user) {
        require(msg.sender == aiAddress || msg.sender == user, "Not authorized");
        _;
    }

    function swapAForB(uint256 amountA, address user) external onlyAIorUser(user) {
        uint256 amountB = getAmountOut(amountA, reserveA, reserveB);
        uint256 fee = (amountB * FEE_PERCENTAGE) / FEE_DENOMINATOR;

        reserveA += amountA;
        reserveB -= (amountB - fee);

        tokenA.transferFrom(user, address(this), amountA);
        tokenB.transfer(user, amountB - fee);
    }

    function swapBForA(uint256 amountB, address user) external onlyAIorUser(user) {
        uint256 amountA = getAmountOut(amountB, reserveB, reserveA);
        uint256 fee = (amountA * FEE_PERCENTAGE) / FEE_DENOMINATOR;

        reserveB += amountB;
        reserveA -= (amountA - fee);

        tokenB.transferFrom(user, address(this), amountB);
        tokenA.transfer(user, amountA - fee);
    }

    function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut) internal pure returns (uint256) {
        uint256 amountInWithFee = amountIn * (FEE_DENOMINATOR - FEE_PERCENTAGE);
        return (amountInWithFee * reserveOut) / (reserveIn * FEE_DENOMINATOR + amountInWithFee);
    }

    function addLiquidity(uint256 amountA, uint256 amountB, address user) external onlyAIorUser(user) {
        reserveA += amountA;
        reserveB += amountB;

        tokenA.transferFrom(user, address(this), amountA);
        tokenB.transferFrom(user, address(this), amountB);

        uint256 lpAmount = (amountA + amountB) / 2; // Simplified calculation for LP tokens
        lpToken.transfer(user, lpAmount);
    }
}
