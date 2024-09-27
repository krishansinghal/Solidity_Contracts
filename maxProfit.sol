// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MaxProfit {

    // This function to calculates the maximum profit
    function maxProfit(uint256[] memory prices) public pure returns (uint256) {
        // Check if the array is empty or has fewer than 2 prices
        if (prices.length < 2) {
            revert("Array must contain at least 2 prices");
        }

        uint256 minPrice = prices[0];
        uint256 maxProfitValue = 0;

        //to calculate the maximum profit
        for (uint256 i = 1; i < prices.length; i++) {
            uint256 currentPrice = prices[i];

            if (currentPrice >= minPrice) {
                uint256 currentProfit = currentPrice - minPrice;
                if (currentProfit > maxProfitValue) {
                    maxProfitValue = currentProfit;
                }
            }

            // Update the minimum price if current price is lower
            if (currentPrice < minPrice) {
                minPrice = currentPrice;
            }
        }

        return maxProfitValue;
    }
}

// This smart contract is used to calculate the max profit from the array of integers.
