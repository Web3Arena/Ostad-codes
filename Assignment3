// SPDX-License-Identifier: MIT

pragma solidity >= 0.8 < 0.9;

/// @title A vote counter for candidates
/// @author Mocarram Hossain
/// @notice You can use this contract for basic vote counting
/// @dev This contract only receives donation, no send feature
contract VotingContract {

    /// @dev Structure to hold candidate information
    struct Candidate {
        string name;
        uint voteCount;
    }

    /// @dev mapping that keeps track of cadidate information
    mapping (string => uint) public candidates;

    /// @dev Initialize vote counts for John and Paul to 0
    constructor () {
        candidates["John"] = 0;
        candidates["Paul"] = 0;
    }

    /// @dev Modifier to ensure votes for valid candidates
    modifier onlyValidCandidate (string memory _name) {
        require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("John")) || 
        keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Paul")), "You are not allowed to vote");
        _;
    }

    /// @notice Event emmited when a donation is received to the contract
    /// @param user The address of the donor
    /// @param amount The donation amount received
    event DonationReceived(address indexed user, uint amount);

    /// @notice Let's a user vote for a candidate
    /// @dev Increments vote count of a candidate
    /// @param _name The name of the candidate
    function vote (string memory _name) public onlyValidCandidate(_name) {
        candidates[_name]++;
    }

    /// @notice Returns vote count for the specified candidate
    /// @param _name The name of a candidate
    /// @return Candidate The candidate's name and their vote count
    function getCandidateVoteCount(string memory _name) public view returns (Candidate memory) {
        Candidate memory candidate;
        candidate.name = _name;
        candidate.voteCount = candidates[_name];
        return candidate;
    } 

    /// @notice Accepts donation to the contract and emits DonationReceived event
    /// @dev Requires donation to be more than 0 Ether
    function donate() external payable {
        require(msg.value > 0, "You can't be a good person donating zero Ether.");
        emit DonationReceived(msg.sender, msg.value);
    }

    /// @notice Function to accept Ether transfer to the contract and emits DonationReceived event
    receive() external payable {
        emit DonationReceived(msg.sender, msg.value);
    }

}
