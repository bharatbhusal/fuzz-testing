// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test} from "forge-std/Test.sol";
import {VotingSystem} from "../src/VotingSystem.sol";

contract VotingSystemTest is Test {
    VotingSystem votingSystem;
    address public owner;
    address public voter;
    address public candidate1;
    address public candidate2;
    address public candidate3;
    address[] public constructorParams;
    address[] public candidates;

    function setUp() public {
        owner = 0x0000000000000000000000000000000000000001;
        voter = 0x0000000000000000000000000000000000000002;
        candidate1 = 0x0000000000000000000000000000000000000032;
        candidate2 = 0x0000000000000000000000000000000000000052;
        candidate3 = 0x0000000000000000000000000000300000000052;
        constructorParams.push(candidate1);
        constructorParams.push(candidate2);

        votingSystem = new VotingSystem(constructorParams);
    }

    function isInArray(
        address value,
        address[] memory array
    ) internal view returns (bool) {
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] == value) {
                return true;
            }
        }
        return false;
    }

    function testAddCandidate() public {
        votingSystem.addCandidate(candidate3);
        candidates = votingSystem.candidates;
        assertEq(isInArray(candidate3, candidates), true);
    }
}
