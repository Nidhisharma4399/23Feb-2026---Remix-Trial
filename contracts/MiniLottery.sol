// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MiniLottery {
    
    address public winner;
    uint256 public entryFee = 0.01 ether; // fake in Remix

    function enter() public payable {
        require(msg.value == entryFee, "Send exactly 0.01 ETH");
        winner = msg.sender; // last one wins (demo only!)
    }

    function getWinner() public view returns (address) {
        return winner;
    }

    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Reset for next round (anyone can call in this demo)
    function reset() public {
        winner = address(0);
    }
}