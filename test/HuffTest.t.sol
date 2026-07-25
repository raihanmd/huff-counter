// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.33;

import {BaseTest} from "./BaseTest.t.sol";
import {ICounter} from "../src/interfaces/ICounter.sol";
import {HuffNeoDeployer} from "foundry-huff-neo/HuffNeoDeployer.sol";

contract HuffTest is BaseTest {
    function setUp() public override {
        counter = ICounter(HuffNeoDeployer.deploy("src/Counter.huff"));
    }
}
