// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StringComparisonContract {
    string public _str1;
    string public _str2;
 
    function compareStrings(string memory str1, string memory str2) external pure returns (bool Matched_) {
       if (bytes(str1).length != bytes(str2).length) {
        return false;
    }

    for (uint i = 0; i < bytes(str1).length; i++) {
        if (bytes(str1)[i] != bytes(str2)[i]) {
            return false;
        }
    }

    return true;
    }
}


// This contract compare the 2 strings and provide the result as string matched or not.