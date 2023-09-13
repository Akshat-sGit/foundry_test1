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

    function testOneVotePerAddress() public {
        // Ensure that the initial vote count for candidate 1 is zero
        uint initialVoteCount = voting.candidates(1).voteCount();
        Assert.equal(initialVoteCount, 0, "Initial vote count for Candidate 1 should be zero.");

        // Voter 1 casts a vote for candidate 1
        voting.vote(1, { from: voter1 });

        // Verify that the vote count for candidate 1 has increased to 1
        uint voteCountAfterVoting = voting.candidates(1).voteCount();
        Assert.equal(voteCountAfterVoting, 1, "Vote count for Candidate 1 should be 1 after voting.");

        // Attempt to vote again from the same address (voter1)
        bool voteExceptionThrown = false;
        try {
            voting.vote(2, { from: voter1 });
        } catch (error) {
            voteExceptionThrown = true;
        }

        // Ensure that an exception was thrown when trying to vote again
        Assert.isTrue(voteExceptionThrown, "Exception should be thrown when trying to vote again from the same address.");
        
        // Verify that the vote count for candidate 2 remains unchanged
        uint voteCountCandidate2 = voting.candidates(2).voteCount();
        Assert.equal(voteCountCandidate2, 0, "Vote count for Candidate 2 should remain unchanged.");
    }

}
