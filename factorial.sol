// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract Factorial {
    uint256 public number=0;
    uint public result =0;
    function factorialNum(uint256 _num) public {
        uint256 fact =1;
        uint i;
        for(i=1; i<=_num; i++){
            fact = fact * i;
        }
         result = fact;
         number = _num;
    }

    function Getvalues() public view returns (uint256 FactResult, uint256 Number) {
        return (result, number);
        

    }
    
}


// This contract is used to find the factorial of any number.