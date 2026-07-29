// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.33;

import {Test} from "forge-std/Test.sol";

import {Counter} from "../../src/Counter.sol";
import {ICounter} from "../../src/interfaces/ICounter.sol";

contract BaseTest is Test {
    ICounter counter;

    function setUp() public virtual {
        counter = ICounter(new Counter());
    }

    function test_workflow() public {
        counter.setNumber(42);
        assertEq(counter.getNumber(), 42);
    }

    function test_fuzz_workflow(uint256 num) public {
        counter.setNumber(num);
        assertEq(counter.getNumber(), num);
    }
}
