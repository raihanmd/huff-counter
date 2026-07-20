// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.30;

import {Test} from "forge-std/Test.sol";

import {Counter} from "../src/Counter.sol";
import {ICounter} from "../src/interfaces/ICounter.sol";
import {HuffNeoDeployer} from "foundry-huff-neo/HuffNeoDeployer.sol";

contract CounterTest is Test {
    ICounter counter;
    ICounter counterHuff;

    function setUp() public {
        counter = ICounter(new Counter());
        counterHuff = ICounter(HuffNeoDeployer.deploy("src/Counter.huff"));
    }

    function test_Sol() public {
        counter.setNumber(42);
        assertEq(counter.getNumber(), 42);
    }

    function test_Huff() public {
        counterHuff.setNumber(42);
        assertEq(counterHuff.getNumber(), 42);
    }
}
