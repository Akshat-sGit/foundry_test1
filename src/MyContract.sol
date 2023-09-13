// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    address public owner;
    mapping(address => bool) public voters;
    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;
    event votedEvent (
        uint indexed _candidateId
    );
    constructor() {
        owner = msg.sender; 
        addCandidate("Candidate A");
        addCandidate("Candidate B");
        addCandidate("Candidate C");
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _; 
    }

    function addCandidate (string memory _name) private onlyOwner {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    function vote (uint _candidateId) public {
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        voters[msg.sender] = true;
        candidates[_candidateId].voteCount ++;
        emit votedEvent(_candidateId);
    }

    // add a function where the contract owner can add and remove candidates
    function addCandidateByOwner (string memory _name) public {
        require(msg.sender == owner);
        addCandidate(_name);
    }
    function removeCandidateByOwner (uint _candidateId) public {
        require(msg.sender == owner);
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        delete candidates[_candidateId];
    }
}