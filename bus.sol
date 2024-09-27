// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TicketBooking {
    uint256 public constant TOTAL_SEATS = 20;
    uint256 public constant MAX_TICKETS_PER_USER = 4;

    // Mapping to store seat bookings (seatNumber => userAddress)
    mapping(uint256 => address) public seatBookings;

    // Mapping to store user's tickets (userAddress => array of booked seat numbers)
    mapping(address => uint256[]) public userTickets;

    // Event emitted when seats are booked
    event SeatsBooked(address indexed user, uint256[] seatNumbers);

    // Function to book seats
    function bookSeats(uint256[] memory seatNumbers) public {
        require(seatNumbers.length > 0, "At least one seat must be booked.");
        require(seatNumbers.length <= MAX_TICKETS_PER_USER, "Can only book up to 4 seats.");
        require(userTickets[msg.sender].length + seatNumbers.length <= MAX_TICKETS_PER_USER, "Exceeds maximum 4 tickets per user.");

        for (uint i = 0; i < seatNumbers.length; i++) {
            uint seat = seatNumbers[i];
            require(seat > 0 && seat <= TOTAL_SEATS, "Invalid seat number.");
            require(seatBookings[seat] == address(0), "Seat already booked.");

            seatBookings[seat] = msg.sender;
            userTickets[msg.sender].push(seat);
        }

        emit SeatsBooked(msg.sender, seatNumbers);
    }

    // Function to show all available seats
    function showAvailableSeats() public view returns (uint256[] memory) {
        uint256[] memory availableSeats = new uint256[](TOTAL_SEATS);
        uint count = 0;

        for (uint i = 1; i <= TOTAL_SEATS; i++) {
            if (seatBookings[i] == address(0)) {
                availableSeats[count] = i;
                count++;
            }
        }

        // Resize array to exclude empty slots
        uint256[] memory result = new uint256[](count);
        for (uint i = 0; i < count; i++) {
            result[i] = availableSeats[i];
        }

        return result;
    }

    // Function to show tickets booked by the user
    function myTickets() public view returns (uint256[] memory) {
        return userTickets[msg.sender];
    }

    // Function to check availability of a specific seat
    function checkAvailability(uint256 seatNumber) public view returns (bool) {
        require(seatNumber > 0 && seatNumber <= TOTAL_SEATS, "Invalid seat number.");
        return seatBookings[seatNumber] == address(0); // Returns true if seat is available
    }
}
