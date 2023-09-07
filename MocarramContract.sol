// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract MocarramContract {

    // State variable to store contract owner addresss
    address private owner;

    // State variable to store a static message
    string message = "Hello Smart Contract!";

    // Contract initiator constructor
    // Set contract creator as the owner
    constructor () {
        owner = msg.sender;
    }

    // OwnerTransfer event
    event OwnerTransfer(address indexed owner, address userAddress, string text);

    // Set new message event
    event MessageSet(string input, string message, string text);

    // Set new message value from the user input
    function setMessageValue(string calldata input) public {
        message = input;
        emit MessageSet(input, message, "Get new message value from the input");
    }

    // Get the message value
    function getMessageValue() public view returns (string memory){
        return message;
    }

    // Get contract owner
    function getContractOwner() public view returns (address) {
        return owner;
    }

    // Transfer ownership to a new address
    function transferOwnership(address userAddress) public {
        require (msg.sender == owner, "Only owner can transfer ownership");
        owner = userAddress;
        emit OwnerTransfer(owner, userAddress, "New Owner set successfully!");
    }
}