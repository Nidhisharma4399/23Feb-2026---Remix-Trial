// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract HelloWeb3 {
    
    string public message = "Hello Remix!";

    function setMessage(string memory newMessage) public {
        message = newMessage;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }
}