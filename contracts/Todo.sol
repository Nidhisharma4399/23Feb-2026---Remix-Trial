// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Todo {
    
    string[] public tasks;

    function addTask(string memory _task) public {
        tasks.push(_task);
    }

    function getTask(uint256 index) public view returns (string memory) {
        return tasks[index];
    }

    function taskCount() public view returns (uint256) {
        return tasks.length;
    }
}