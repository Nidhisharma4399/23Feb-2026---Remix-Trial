// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TipJar {
    
    address public owner;
    uint256 public totalTips;

    constructor() {
        owner = msg.sender;
    }

    // Anyone can send ETH to this contract
    receive() external payable {
        totalTips += msg.value;
    }

    // Check balance (in wei)
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Only owner can withdraw - modern safe way
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");

        uint256 amount = address(this).balance;
        require(amount > 0, "No funds to withdraw");

        // Modern replacement for transfer()
        (bool success, ) = payable(owner).call{value: amount}("");
        
        require(success, "Withdrawal failed");
    }
}