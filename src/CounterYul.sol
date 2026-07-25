// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.33;

import {ICounter} from "./interfaces/ICounter.sol";

contract CounterYul is ICounter {
    uint256 private number;

    function setNumber(uint256 newNumber) external {
        assembly {
            sstore(number.slot, newNumber)
        }
    }

    function getNumber() external view returns (uint256) {
        assembly {
            let num := sload(number.slot)
            mstore(0, num)
            return(0, 0x20)
        }
    }
}
