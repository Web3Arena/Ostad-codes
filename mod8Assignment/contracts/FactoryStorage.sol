// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FactoryStorage {
    address[] tokens;
    address public logicContract;

    modifier onlyLogic() {
        require(msg.sender == logicContract, "Not authorized");
        _;
    }

    function setLogicContract(address _logicContract) external onlyLogic {
        logicContract = _logicContract;
    }

    function addToken(address token) external onlyLogic {
        tokens.push(token);
    }

    function getTokens() external view returns (address[] memory) {
        return tokens;
    }
}
