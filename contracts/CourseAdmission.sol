// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract CourseAdmission {
    
    // Fixed course fee = 1 ETH (written as 1 ether in Solidity)
    uint256 public constant COURSE_FEE = 1 ether;
    
    // Owner of the contract (the institute/teacher)
    // You can later add withdraw function only for owner
    address public owner;
    
    // Keeps track of who has paid and is enrolled
    // true = enrolled, false = not enrolled (default)
    mapping(address => bool) public isEnrolled;
    
    // Optional: how much each person actually paid (for debugging)
    mapping(address => uint256) public paidAmount;

    // Event so you can see enrollments in Remix or frontend later
    event StudentEnrolled(address indexed student, uint256 amountPaid);

    // Constructor runs only once when contract is deployed
    constructor() {
        owner = msg.sender;     // The person who deploys = owner
    }

    // Main function: student calls this to pay and enroll
    // payable = this function can receive ETH
    function enrol() external payable {
        // Check if they sent enough money
        require(msg.value >= COURSE_FEE, "You must send at least 1 ETH to enroll");

        // Mark them as enrolled
        isEnrolled[msg.sender] = true;
        
        // Optional: remember how much they sent
        paidAmount[msg.sender] = msg.value;

        // Tell the world someone enrolled (visible in Remix "Logs")
        emit StudentEnrolled(msg.sender, msg.value);
    }

    // Anyone can call this to check contract's ETH balance
    function getContractBalance() external view returns (uint256) {
        // address(this).balance is the ETH inside this contract
        return address(this).balance;
    }

    // Optional helper function: check your own status
    function amIEnrolled() external view returns (bool) {
        return isEnrolled[msg.sender];
    }

    // Optional: only owner can withdraw all money later (for real use)
    // Remove or comment this if you want money to stay forever in contract
    function withdraw() external {
        require(msg.sender == owner, "Only owner can withdraw");

        uint256 amount = address(this).balance;
        require(amount > 0, "No funds to withdraw");

        (bool success, ) = payable(owner).call{value: amount}("");
        require(success, "Withdrawal failed");
    }
}