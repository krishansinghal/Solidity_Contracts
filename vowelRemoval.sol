// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RemoveVowels {
    
    
    function removeVowels(string memory input) public pure returns (string memory) {
        bytes memory inputBytes = bytes(input);
        bytes memory result = new bytes(inputBytes.length); 
        uint index = 0;

        
        for (uint i = 0; i < inputBytes.length; i++) {
            
            if (
                inputBytes[i] != 'a' && inputBytes[i] != 'e' && inputBytes[i] != 'i' && inputBytes[i] != 'o' && inputBytes[i] != 'u' &&
                inputBytes[i] != 'A' && inputBytes[i] != 'E' && inputBytes[i] != 'I' && inputBytes[i] != 'O' && inputBytes[i] != 'U'
            ) {
                result[index] = inputBytes[i]; 
                index++;
            }
        }

        
        bytes memory finalResult = new bytes(index);
        for (uint j = 0; j < index; j++) {
            finalResult[j] = result[j];
        }

        return string(finalResult); 
    }
}

// This contract has the functionality to find and remove the vowel from a string.
