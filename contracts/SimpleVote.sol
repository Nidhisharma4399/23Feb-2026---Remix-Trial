// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleVote {
    
    uint256 public yesVotes;
    uint256 public noVotes;

    mapping(address => bool) public hasVoted;

    function vote(bool _voteYes) public {
        require(!hasVoted[msg.sender], "You already voted!");
        
        hasVoted[msg.sender] = true;
        
        if (_voteYes) {
            yesVotes += 1;
        } else {
            noVotes += 1;
        }
    }

    function getResults() public view returns (uint256 yes, uint256 no) {
        return (yesVotes, noVotes);
    }
}