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

    function setUp() public {
        votingSystem = new VotingSystem(constructorParams);
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
        user3 = makeAddr("user3");
    }

    function test_addCandidate(address newCandidate) public {
        votingSystem.addCandidate(newCandidate);
        assert(votingSystem.getCandidates()[0] == newCandidate);
    }

    function test_getCandidate() public {
        votingSystem.addCandidate(makeAddr("me"));
        votingSystem.addCandidate(makeAddr("you"));
        votingSystem.addCandidate(makeAddr("and"));
        votingSystem.addCandidate(makeAddr("they"));
        votingSystem.addCandidate(makeAddr("are"));

        assert(votingSystem.getCandidates()[0] == makeAddr("me"));
        assert(votingSystem.getCandidates()[3] == makeAddr("they"));
        assert(votingSystem.getCandidates()[4] == makeAddr("are"));
    }

    function test_hasNotVoted(address voter) public view {
        assert(votingSystem.hasVoted(voter) == false);
    }

    function test_hasVoted() public {
        votingSystem.addCandidate(makeAddr("are"));
        votingSystem.vote(0);
        assert(votingSystem.hasVoted(address(this)) == true);
    }

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

    // function test_getTotalVotes() public {
    //     votingSystem.addCandidate(makeAddr("are"));
    //     (user1, ) = makeAddrAndKey("user1");

    //     user1.vote(0);
    // }
}
