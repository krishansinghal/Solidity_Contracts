// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TicketBooking {
    uint constant TOTAL_SEATS = 20; // Total number of seats
    mapping(uint => bool) public seatAvailability; // Mapping to track seat availability
    mapping(address => uint[]) private userTickets; // Mapping to track tickets booked by each user

    constructor() {
        // Initialize all seats as available
        for (uint i = 1; i <= TOTAL_SEATS; i++) {
            seatAvailability[i] = true;
        }
    }

    
    function bookSeats(uint[] calldata seatNumbers) public {
        require(seatNumbers.length > 0, "Must book at least one seat.");
        require(seatNumbers.length <= 4, "Cannot book more than 4 seats at a time.");

        for (uint i = 0; i < seatNumbers.length; i++) {
            uint seatNumber = seatNumbers[i];
            require(seatNumber > 0 && seatNumber <= TOTAL_SEATS, "Invalid seat number.");
            require(seatAvailability[seatNumber], "Seat is already booked.");

            // Mark the seat as booked
            seatAvailability[seatNumber] = false;
            // Store the booked ticket for the user
            userTickets[msg.sender].push(seatNumber);
        }
    }

   
    function showAvailableSeats() public view returns (uint[] memory) {
        uint availableCount = 0;

        // Count available seats
        for (uint i = 1; i <= TOTAL_SEATS; i++) {
            if (seatAvailability[i]) {
                availableCount++;
            }
        }

        uint[] memory availableSeats = new uint[](availableCount);
        uint index = 0;

        // Fill the availableSeats array
        for (uint i = 1; i <= TOTAL_SEATS; i++) {
            if (seatAvailability[i]) {
                availableSeats[index] = i;
                index++;
            }
        }

        return availableSeats;
    }

  
    function checkAvailability(uint seatNumber) public view returns (bool) {
        require(seatNumber > 0 && seatNumber <= TOTAL_SEATS, "Invalid seat number.");
        return seatAvailability[seatNumber];
    }

   
    function myTickets() public view returns (uint[] memory) {
        return userTickets[msg.sender];
    }
}


// This smart contract has the  functionality to book the bus tickets.
// the  user can book 4 ticket max at a time.