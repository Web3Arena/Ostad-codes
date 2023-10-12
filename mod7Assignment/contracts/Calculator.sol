// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Calculator is Ownable {
    using SafeMath for uint256;

    uint256 private lastResult;
    uint256 private addResult;
    uint256 private subResult;
    uint256 private mulResult;
    uint256 private divResult;

    function add(uint256 _a, uint256 _b) public onlyOwner {
        addResult = _a.add(_b);
        lastResult = addResult;
    }

    function subtract(uint256 _a, uint256 _b) public onlyOwner {
        subResult = _a.sub(_b);
        lastResult = subResult;
    }

    function multiply(uint256 _a, uint256 _b) public onlyOwner {
        mulResult = _a.mul(_b);
        lastResult = mulResult;
    }

    function divide(uint256 _a, uint256 _b) public onlyOwner {
        require(_b > 0, "Denominator must be positive and non zero");
        divResult = _a.div(_b);
        lastResult = divResult;
    }

    function getLastResult() public view returns (uint256) {
        return lastResult;
    }
}
