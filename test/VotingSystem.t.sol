// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test} from "forge-std/Test.sol";
import "forge-std/Console.sol";
import {VotingSystem} from "../src/VotingSystem.sol";

contract VotingSystemTest is Test {
    VotingSystem votingSystem;
    address user1;
    address user2;
    address user3;
    address[] public constructorParams;

    /**
     * @dev Set up function to initialize test environment
     */
    function setUp() public {
        votingSystem = new VotingSystem(constructorParams);
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
        user3 = makeAddr("user3");
    }

    /**
     * @dev Test function to add a new candidate
     * @param newCandidate Address of the new candidate to be added
     */
    function test_addCandidate(address newCandidate) public {
        votingSystem.addCandidate(newCandidate);
        assert(votingSystem.getCandidates()[0] == newCandidate);
    }

    /**
     * @dev Test function to get the list of all candidates
     */
    function test_getCandidates() public {
        votingSystem.addCandidate(makeAddr("me"));
        votingSystem.addCandidate(makeAddr("you"));
        votingSystem.addCandidate(makeAddr("and"));
        votingSystem.addCandidate(makeAddr("they"));
        votingSystem.addCandidate(makeAddr("are"));

        assert(votingSystem.getCandidates()[0] == makeAddr("me"));
        assert(votingSystem.getCandidates()[3] == makeAddr("they"));
        assert(votingSystem.getCandidates()[4] == makeAddr("are"));
    }

    /**
     * @dev Test function to check if a voter has not voted
     * @param voter Address of the voter
     */
    function test_hasNotVoted(address voter) public view {
        assert(votingSystem.hasVoted(voter) == false);
    }

    /**
     * @dev Test function to check if a voter has voted
     */
    function test_hasVoted() public {
        votingSystem.addCandidate(makeAddr("are"));
        votingSystem.vote(0);
        assert(votingSystem.hasVoted(address(this)) == true);
    }

    /**
     * @dev Test function to vote for a candidate
     * @param candidateIndex Index of the candidate being voted for
     */
    function test_vote(uint256 candidateIndex) public {
        votingSystem.addCandidate(makeAddr("me"));
        votingSystem.addCandidate(makeAddr("you"));
        votingSystem.addCandidate(makeAddr("and"));
        votingSystem.addCandidate(makeAddr("they"));
        votingSystem.addCandidate(makeAddr("are"));
        vm.assume(candidateIndex <= votingSystem.getCandidates().length - 1);
        votingSystem.vote(candidateIndex);
        assert(votingSystem.getTotalVotes(candidateIndex) == 1);
    }

    /**
     * @dev Test function to get the total votes received by a candidate
     */
    function test_getTotalVotes() public {
        votingSystem.addCandidate(makeAddr("are"));
        user1 = makeAddr("user1");
        vm.startPrank(user1);
        votingSystem.vote(0);
        vm.stopPrank();

        user2 = makeAddr("user2");
        vm.startPrank(user2);
        votingSystem.vote(0);
        vm.stopPrank();

        assert(votingSystem.getTotalVotes(0) == 2);
    }

    /**
     * @dev Test function to remove a candidate
     * @param candidateIndex Index of the candidate to be removed
     */
    function test_removeCandidate(uint256 candidateIndex) public {
        votingSystem.addCandidate(makeAddr("are"));
        assert(votingSystem.getCandidates()[0] == makeAddr("are"));
        vm.assume(candidateIndex <= votingSystem.getCandidates().length - 1);
        votingSystem.removeCandidate(candidateIndex);
        assert(votingSystem.getCandidates()[0] != makeAddr("are"));
    }
}
