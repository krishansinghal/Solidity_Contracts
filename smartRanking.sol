// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SmartRanking {

    struct Student {
        uint rollNumber;
        uint marks;
    }

    Student[] public students;

    // Insert roll number and corresponding marks
    function insertMarks(uint _rollNumber, uint _marks) public {
    
        students.push(Student({
            rollNumber: _rollNumber,
            marks: _marks
        }));
    }

    // Sort students by marks in descending order
    function sortStudents() internal view returns (Student[] memory) {
        Student[] memory sortedStudents = students;

        // Bubble sort algorithm
        uint n = sortedStudents.length;
        for (uint i = 0; i < n; i++) {
            for (uint j = 0; j < n - 1; j++) {
                if (sortedStudents[j].marks < sortedStudents[j + 1].marks) {
                    // Swap students if the current one has lower marks than the next
                    Student memory temp = sortedStudents[j];
                    sortedStudents[j] = sortedStudents[j + 1];
                    sortedStudents[j + 1] = temp;
                }
            }
        }
        return sortedStudents;
    }

    // Get the marks of the student as per the rank (1-based index)
    function scoreByRank(uint rank) public view returns(uint) {
        require(rank > 0 && rank <= students.length, "Invalid rank");
        
        // Sort students by marks
        Student[] memory sortedStudents = sortStudents();

        // Return the marks of the student with the given rank
        return sortedStudents[rank - 1].marks;
    }

    // Get the roll number of the student as per the rank (1-based index)
    function rollNumberByRank(uint rank) public view returns(uint) {
        require(rank > 0 && rank <= students.length, "Invalid rank");
        
        // Sort students by marks
        Student[] memory sortedStudents = sortStudents();

        // Return the roll number of the student with the given rank
        return sortedStudents[rank - 1].rollNumber;
    }
}
