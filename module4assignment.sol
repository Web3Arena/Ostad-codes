// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title A contract to create and manage tokens
contract TokensContract {

    /// @notice Shape of a token
    struct Token {
        string name;
        string symbol;
        uint totalSupply;
    }

    /// @notice holds all the created tokens
    Token[] tokens;

    /// @notice maps address and balance to the token symbol
    mapping (string => mapping(address => uint)) balances;

    /// @notice holds mapping for token existence
    mapping (string => bool) tokenExists;

    /// @dev Modifier to ensure token exists
    modifier CheckTokenExistence (string memory _symbol) {
        require(tokenExists[_symbol], "Token does not exist!");
        _;
    }

    /// @dev Modifier to ensure balance is higher than the transfer amount
    modifier CheckBalance (string memory _symbol, uint _amount) {
        require(balances[_symbol][msg.sender] >= _amount, "You don\'t have sufficient amount to transfer!");
        _;
    }

    /// @notice Emits the event on token creation
    event TokenCreated(address indexed owner, string indexed symbol, uint totalSupply);

    /// @notice Emits the event on token transfer
    event TokenTransferred(string indexed symbol, address indexed sender, address indexed to, uint amount);

    /// @notice Creates a new token
    /// @param _name Token name
    /// @param _symbol Token symbol
    /// @param _totalSupply Initial token supply
    function createToken (string memory _name, string memory _symbol, uint _totalSupply) public {
        require(!tokenExists[_symbol], "Token with this symbol aleady exists!");

        tokens.push(Token(_name, _symbol, _totalSupply));
        balances[_symbol][msg.sender] = _totalSupply;
        tokenExists[_symbol] = true;

        emit TokenCreated(msg.sender, _symbol, _totalSupply);
    }

    /// @notice Transfers token to the recipient 
    /// @param _symbol Token symbol
    /// @param _recipient Recipient address
    /// @param _amount Token amount to transfer
    /// @dev requires token to be existed and balance should be equal or more than the transfer amount
    function transferToken(string memory _symbol, address _recipient, uint _amount) public CheckTokenExistence(_symbol) CheckBalance(_symbol, _amount) {
        balances[_symbol][msg.sender] -= _amount;
        balances[_symbol][_recipient] += _amount;

        emit TokenTransferred(_symbol, msg.sender, _recipient, _amount);
    }

    /// @notice Gets balance by a token
    /// @param _symbol Token symbol
    /// @param _address Token owner address
    function getBalanceByToken(string memory _symbol, address _address) public view returns (uint) {
        return balances[_symbol][_address];
    }

    /// @notice Prints the length of the tokens in the contract
    function getTotalTokenCount () public view returns (uint) {
        return tokens.length;
    }

}
