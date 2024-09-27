// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract Owner {
    
    function ownerIs() external view  returns(address owner_) {
        return msg.sender;
    }
}


// This contract return the address of the owner.