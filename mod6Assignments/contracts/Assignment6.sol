// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Assignment6 is Ownable {
    string name = "Hello World!";

    function getName() public view returns (string memory) {
        return name;
    }

    function setName(string memory _name) public onlyOwner {
        name = _name;
    }
}
