// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "forge-std/Test.sol";

import '../src/MyContract.sol';

contract TestVoting is Test{
    Voting public voting;

    function setUp() public {
        voting = new Voting();
    }

    // Test the initial state of the contract
    function testInitialState() public {
        uint expectedCandidatesCount = 3;

        // Check if the contract owner is set correctly
        assertEq(voting.owner(), address(this), "Contract owner should be this test contract.");

        // Check the initial number of candidates
        assertEq(voting.candidatesCount(), expectedCandidatesCount, "Initial candidates count should be 3.");
    }

    // Test adding a candidate by the contract owner
    function testAddCandidateByOwner() public {
        string memory candidateName = "Candidate D";
        voting.addCandidateByOwner(candidateName);

        uint newCandidatesCount = voting.candidatesCount();
        // Voting.Candidate memory addedCandidate = voting.candidates(newCandidatesCount);

        // Check if the candidate count has increased
        assertEq(newCandidatesCount, 4, "Candidates count should increase after adding a candidate.");

    }
    function testRemoveCandidateByOwner() public{ 
        uint newCandidatesCount = voting.candidatesCount();
        voting.removeCandidateByOwner(newCandidatesCount);
        assertEq(newCandidatesCount,3, "Candidates count should decrease after removing a candidate.");
    }
}
