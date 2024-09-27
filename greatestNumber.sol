// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Max{
    uint256[] array;
    uint256  GreatestNumberIs;
    
   function getLargest(uint256[] memory _numbers) public{
       
       uint max = 0;
        uint i;
        
       for(i=0;i< _numbers.length;i++){
           if(max<_numbers[i]){
               max = _numbers[i];
           }
       }
       GreatestNumberIs =  max;
       array = _numbers;
   }

   function getArray() public view returns(uint256[] memory numbers, uint256 GreatestNumberIs_){
    return(array, GreatestNumberIs);
   }
}



// This contract is used to find the  greatest number in the array.