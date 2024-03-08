# Voting System Smart Contract

This project consists of a simple smart contract written in Solidity for managing a voting system. Users can cast their votes for candidates, and the contract owner can manage the list of candidates.

## Smart Contract File

- **VotingSystem.sol**: Contains the Solidity code for the voting system smart contract. It includes the following functionalities:

  - `addCandidate`: Allows the contract owner to add a new candidate to the list.
  - `removeCandidate`: Allows the contract owner to remove a candidate from the list.
  - `vote`: Allows a voter to cast a vote for a candidate.
  - `getTotalVotes`: Retrieves the total number of votes received by a candidate.
  - `hasVoted`: Checks if a voter has already cast a vote.
  - `getCandidates`: Retrieves the list of all candidates.

## Test File

- **VotingSystemTest.sol**: Contains test cases written in Solidity to test the functionalities of the `VotingSystem.sol` smart contract. The tests include:

  - `test_addCandidate`: Verifies that a candidate can be successfully added to the list.
  - `test_getCandidate`: Ensures that the list of candidates is retrieved correctly.
  - `test_hasNotVoted`: Checks if a voter has not voted initially.
  - `test_hasVoted`: Verifies that a voter is marked as having voted after casting a vote.
  - `test_vote`: Tests the functionality of casting a vote for a candidate.

## Fuzz Testing

Fuzz testing, also known as fuzzing, is a software testing technique used to discover vulnerabilities or errors in programs by providing invalid, unexpected, or random data as inputs. In the context of smart contracts, fuzz testing involves subjecting the contract to a wide range of inputs, including edge cases and unexpected values, to identify potential security vulnerabilities, bugs, or unintended behaviors. By executing the contract with various inputs generated programmatically or randomly, fuzz testing aims to uncover weaknesses that may not be identified through traditional testing methods. Implementing fuzz testing in smart contract development helps enhance security and robustness by identifying and addressing potential issues early in the development lifecycle.

## Installation and Setup

1. Clone the repository:

```
git clone https://github.com/bharatbhusal/fuzz-testing.git
```

2. Navigate to the project directory:

```
cd fuzz-testing
```

3. Install dependencies:

```
forge install
```

## Running Tests

To run the tests for the smart contract, follow these step:

1. Run the tests:

```
forge test
```

## Usage

You can deploy the `VotingSystem` contract to a compatible blockchain network and interact with it using a wallet or a decentralized application (DApp).
