// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ICounter} from "./interfaces/ICounter.sol";

contract Counter is ICounter {
    uint256 private number;

    function setNumber(uint256 newNumber) external {
        number = newNumber;
    }

    function getNumber() external view returns (uint256) {
        return number;
    }
}
