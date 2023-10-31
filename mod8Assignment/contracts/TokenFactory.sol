// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenContract.sol";
import "./TokenStorage.sol";
import "./FactoryStorage.sol";

contract TokenFactory {
    FactoryStorage public storageContract;

    constructor(address _factoryStorageAddress) {
        storageContract = FactoryStorage(_factoryStorageAddress);
    }

    function createToken(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) public returns (address) {
        TokenStorage newTokenStorage = new TokenStorage();
        TokenContract newTokenLogic = new TokenContract(
            address(newTokenStorage)
        );

        newTokenStorage.setLogicContract(address(newTokenLogic));
        newTokenStorage.setName(_name);
        newTokenStorage.setSymbol(_symbol);
        newTokenStorage.setFactory(address(this));

        newTokenLogic.mint(msg.sender, _initialSupply);

        storageContract.addToken(address(newTokenLogic));

        return address(newTokenLogic);
    }

    function getTokens() public view returns (address[] memory) {
        return storageContract.getTokens();
    }
}
