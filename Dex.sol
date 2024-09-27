// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX is ERC20 {
    address public token;
    uint256 public totalLiquidity;
    mapping(address => uint256) public liquidity;
    
    uint256 public constant FEE_PERCENT = 1; // 1% fee on swaps
    uint256 public constant FEE_DENOMINATOR = 100;

    constructor(address _token) ERC20("DEX LP Token", "DEX-LP") {
        token = _token;
    }

    /*
     * @dev addLiquidity allows users to add liquidity to the DEX.
     *      Mints LP tokens to represent share in the liquidity pool.
     */
    function addLiquidity(uint256 tokenAmount) public payable returns (uint256) {
        IERC20 tokenContract = IERC20(token);
        uint256 ethReserve = address(this).balance - msg.value;
        uint256 tokenReserve = getReserve();

        if (totalLiquidity == 0) {
            // First-time liquidity: ETH & Token supply sets the initial ratio
            totalLiquidity = address(this).balance;
            liquidity[msg.sender] = totalLiquidity;
            _mint(msg.sender, totalLiquidity); // Mint LP tokens

            require(tokenContract.transferFrom(msg.sender, address(this), tokenAmount), "Token transfer failed");
            return totalLiquidity;
        } else {
            // Maintain ETH-Token ratio
            uint256 ethAmount = msg.value;
            uint256 requiredTokenAmount = (ethAmount * tokenReserve) / ethReserve;
            require(tokenAmount >= requiredTokenAmount, "Insufficient token amount");

            liquidity[msg.sender] += ethAmount;
            totalLiquidity += ethAmount;

            _mint(msg.sender, (totalSupply() * ethAmount) / ethReserve); // Mint LP tokens based on the ratio

            // Only transfer the exact amount of tokens required
            require(tokenContract.transferFrom(msg.sender, address(this), requiredTokenAmount), "Token transfer failed");

            return liquidity[msg.sender];
        }
    }

    /*
     * @dev removeLiquidity allows users to remove liquidity from the DEX.
     *      Burns LP tokens and sends back ETH and tokens.
     */
    function removeLiquidity(uint256 amountOfLPTokens) public returns (uint256, uint256) {
        require(balanceOf(msg.sender) >= amountOfLPTokens, "Not enough LP tokens");

        uint256 ethAmount = (amountOfLPTokens * address(this).balance) / totalSupply();
        uint256 tokenAmount = (amountOfLPTokens * getReserve()) / totalSupply();

        _burn(msg.sender, amountOfLPTokens);
        totalLiquidity -= ethAmount;

        payable(msg.sender).transfer(ethAmount);
        require(IERC20(token).transfer(msg.sender, tokenAmount), "Token transfer failed");

        return (ethAmount, tokenAmount);
    }

    /*
     * @dev ethToTokenSwap allows users to swap ETH for tokens with a 1% fee.
     */
    function ethToTokenSwap() external payable {
        require(msg.value > 0, "Must send ETH");

        uint256 ethReserve = address(this).balance - msg.value;
        uint256 tokenReserve = getReserve();

        // 1% fee, user only gets 99% of the value considered
        uint256 ethAmountWithFee = (msg.value * (FEE_DENOMINATOR - FEE_PERCENT)) / FEE_DENOMINATOR;

        uint256 tokenAmount = (ethAmountWithFee * tokenReserve) / ethReserve;

        require(IERC20(token).transfer(msg.sender, tokenAmount), "Token transfer failed");
    }

    /*
     * @dev tokenToEthSwap allows users to swap tokens for ETH with a 1% fee.
     * @param tokenAmount - Amount of tokens to swap for ETH
     */
    function tokenToEthSwap(uint256 tokenAmount) public {
        require(tokenAmount > 0, "Must send tokens");

        uint256 ethReserve = address(this).balance;
        uint256 tokenReserve = getReserve();

        // 1% fee, user only gets 99% of the tokens considered
        uint256 tokenAmountWithFee = (tokenAmount * (FEE_DENOMINATOR - FEE_PERCENT)) / FEE_DENOMINATOR;

        uint256 ethAmount = (tokenAmountWithFee * ethReserve) / tokenReserve;

        require(IERC20(token).transferFrom(msg.sender, address(this), tokenAmount), "Token transfer failed");
        payable(msg.sender).transfer(ethAmount);
    }

    /*
     * @dev getReserve returns the balance of the ERC-20 tokens held by the DEX.
     */
    function getReserve() public view returns (uint256) {
        return IERC20(token).balanceOf(address(this));
    }
}
