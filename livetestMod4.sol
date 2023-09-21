// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingContract {
    address public owner;

    // Define an enum `CandidateStatus` to represent the status of a candidate (Pending, Approved, Disqualified)
    enum CandidateStatus {
        Pending,
        Approved,
        Disqualified
    }

    // Define a struct to represent a candidate with name, votes and status with the type of `CandidateStatus` Enum
    struct Candidate {
        string name;
        uint256 votes;
        CandidateStatus status;
    }

    // `candidates` Mapping to store by their address and `Candidate` struct
    mapping(address => Candidate) candidates;

    // Initialize the owner
    constructor() {
        owner = msg.sender;
    }

    // Create a modifier to restrict certain functions to the owner only
    modifier OnlyOwner() {
        require(msg.sender == owner, "You need to be the owner");
        _;
    }

    // Create a function to add a candidate (Only owner)
    function addCandidate(address _address, string memory _name)
        public
        OnlyOwner
    {
        candidates[_address] = Candidate({
            name: _name,
            votes: 0,
            status: CandidateStatus.Pending
        });
    }

    // Create a function to remove a candidate (Only owner)
    function removeCandidate(address _address) public OnlyOwner {
        require(
            candidates[_address].status != CandidateStatus.Disqualified,
            "Already Disqualified"
        );
        candidates[_address].status = CandidateStatus.Disqualified;
    }

    // Create a function to vote for a candidate where anyone can vote the candidate
    function vote(address _address) public {
        require(
            candidates[_address].status == CandidateStatus.Approved,
            "Candidate Disqualified for voting"
        );
        candidates[_address].votes++;
    }

    // Create a function to get the total votes received by a candidate
    function getTotalVotesForCandidate(address _address)
        public
        view
        returns (uint256)
    {
        return candidates[_address].votes;
    }

    // Create a function to get the status of a candidate
    function getCandidateStatus(address _address)
        public
        view
        returns (CandidateStatus)
    {
        return candidates[_address].status;
    }

    // Create a function to change the status of a candidate (Only owner)
    function approveCandidate(address _address) public {
        require(
            candidates[_address].status == CandidateStatus.Pending,
            "Candidate is not pending"
        );
        candidates[_address].status = CandidateStatus.Approved;
    }
}
