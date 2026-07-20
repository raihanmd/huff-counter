// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICounter {
    function setNumber(uint256) external;
    function getNumber() external view returns (uint256);
}
