// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenStorage {
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;
    uint256 public totalSupply;
    string public name;
    string public symbol;
    address public factory;
    address public logicContract;

    modifier onlyLogic() {
        require(msg.sender == logicContract, "Not authorized");
        _;
    }

    function setLogicContract(address _logicContract) external onlyLogic {
        logicContract = _logicContract;
    }

    function setTotalSupply(uint256 _totalSupply) external onlyLogic {
        totalSupply = _totalSupply;
    }

    function setBalance(address account, uint256 _balance) external onlyLogic {
        balances[account] = _balance;
    }

    function setAllowance(
        address owner,
        address spender,
        uint256 value
    ) external onlyLogic {
        allowances[owner][spender] = value;
    }

    function setFactory(address _factory) external onlyLogic {
        factory = _factory;
    }

    function setName(string memory _name) external onlyLogic {
        name = _name;
    }

    function setSymbol(string memory _symbol) external onlyLogic {
        symbol = _symbol;
    }

    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }

    function getAllowance(
        address owner,
        address spender
    ) external view returns (uint256) {
        return allowances[owner][spender];
    }
}
