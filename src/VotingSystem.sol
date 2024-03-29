// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

/**
 * @title VotingSystem
 * @dev A simple voting contract where users can vote for candidates.
 */
contract VotingSystem {
    // The address of the contract owner
    address public owner;

    // An array to store the addresses of candidates
    address[] public candidates;

    // Mapping to track whether an address has voted
    mapping(address => bool) public voters;

    // Mapping to store the number of votes received by each candidate
    mapping(address => uint256) votesReceived;

    // Event emitted when a voter casts a vote
    event Voted(address indexed voter, address candidate);

    // Event emitted when a candidate is removed
    event CandidateRemoved(address candidate, uint256 candidateIndex);

    // Event emitted when a candidate is added
    event CandidateAdded(address candidate, uint256 candidateIndex);

    // Modifier to ensure that a voter has not voted before
    modifier newVoter() {
        require(!voters[msg.sender], "Already voted");
        _;
    }

    // Modifier to ensure that the candidate index is valid
    modifier validCandidate(uint256 _candidateIndex) {
        require(_candidateIndex < candidates.length, "Invalid Candidate Index");
        require(
            candidates[_candidateIndex] != address(0),
            "Candidate removed by Admin"
        );
        _;
    }

    // Modifier to ensure that the caller is the owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    // Modifier to ensure that the new candidate being added is not a duplicate
    modifier duplicateNewCandidate(address newCandidate) {
        for (uint i = 0; i < candidates.length; i++) {
            require(newCandidate != candidates[i], "Candidate already exists");
        }

        _;
    }

    /**
     * @dev Constructor to initialize the contract with candidate addresses
     * @param _candidates Array of initial candidate addresses
     */
    constructor(address[] memory _candidates) {
        owner = msg.sender;
        candidates = _candidates;
    }

    /**
     * @dev Function to add a new candidate by the contract owner
     * @param _candidateAddress Address of the new candidate to be added
     */
    function addCandidate(
        address _candidateAddress
    ) public onlyOwner duplicateNewCandidate(_candidateAddress) {
        candidates.push(_candidateAddress);

        emit CandidateAdded(_candidateAddress, candidates.length - 1);
    }

    /**
     * @dev Function to remove a candidate by the contract owner
     * @param _candidateIndex Index of the candidate to be removed
     */
    function removeCandidate(
        uint256 _candidateIndex
    ) public onlyOwner validCandidate(_candidateIndex) {
        address candidateAddress = candidates[_candidateIndex];
        delete candidates[_candidateIndex];

        emit CandidateRemoved(candidateAddress, _candidateIndex);
    }

    /**
     * @dev Function for a voter to cast a vote
     * @param _candidateIndex Index of the candidate being voted for
     */
    function vote(
        uint256 _candidateIndex
    ) public newVoter validCandidate(_candidateIndex) {
        voters[msg.sender] = true;
        votesReceived[candidates[_candidateIndex]] += 1;

        emit Voted(msg.sender, candidates[_candidateIndex]);
    }

    /**
     * @dev Function to get the total votes received by a candidate
     * @param _candidateIndex Index of the candidate
     * @return uint256 Total number of votes received by the candidate
     */
    function getTotalVotes(
        uint256 _candidateIndex
    ) public view returns (uint256) {
        return votesReceived[candidates[_candidateIndex]];
    }

    /**
     * @dev Function to check if a voter has already voted
     * @param _voter Address of the voter
     * @return bool Whether the voter has already voted or not
     */
    function hasVoted(address _voter) public view returns (bool) {
        return voters[_voter];
    }

    /**
     * @dev Function to get the list of all candidates
     * @return address[] Array of candidate addresses
     */
    function getCandidates() public view returns (address[] memory) {
        return candidates;
    }
}
