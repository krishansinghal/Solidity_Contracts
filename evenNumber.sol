// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EvenOddContract {
  
    function isEven(uint256 number) external pure returns (bool isEven_) {
       if(number == 0){
          return false;
       }
       if(number % 2 != 0){
        return false;
       }
       else 
       return true;
    }
}

//This contract is used to find if a number is even or not.