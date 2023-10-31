// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenStorage.sol";

contract TokenContract {
    TokenStorage public storageContract;

    constructor(address _storageAddress) {
        storageContract = TokenStorage(_storageAddress);
    }

    function mint(address to, uint256 amount) public {
        require(
            msg.sender == storageContract.factory(),
            "Only factory can mint"
        );
        storageContract.setTotalSupply(storageContract.totalSupply() + amount);
        storageContract.setBalance(to, storageContract.getBalance(to) + amount);
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(
            storageContract.getBalance(msg.sender) >= amount,
            "Insufficient balance"
        );
        storageContract.setBalance(
            msg.sender,
            storageContract.getBalance(msg.sender) - amount
        );
        storageContract.setBalance(to, storageContract.getBalance(to) + amount);
        return true;
    }
}
