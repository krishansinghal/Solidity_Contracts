// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract Storage {
    uint256 public value= 15;

    function setValue(uint256 _value) public {
        value = _value; 
    }

    function getValue() public view returns (uint256) {
        return value;
    }
}

// This Contract has the functionality to store  the value  and return the stored value