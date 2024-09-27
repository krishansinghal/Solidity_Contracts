// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinaryConverter {

    function toBinary(uint8 num) public pure returns (string memory) {
        bytes memory binary = new bytes(8); 
        
        for (uint i = 0; i < 8; i++) {
            // Get the i-th bit of the number by shifting right and checking the least significant bit
            if ((num & (1 << (7 - i))) != 0) {
                binary[i] = '1'; // Set to '1' if the bit is set
            } else {
                binary[i] = '0'; // Set to '0' if the bit is not set
            }
        }

        return string(binary);
    }
}

//This smart contract is used to convert the decimal to 8 bit binary number.