// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {HorseNFTBaseTest, HorseNFT} from "./HorseNFTBaseTest.t.sol";
import {HuffNeoDeployer} from "foundry-huff-neo/HuffNeoDeployer.sol";

contract HuffHorseNFTTest is HorseNFTBaseTest {
    function setUp() public override {
        horseNft = HorseNFT(
            address(
                HuffNeoDeployer.deploy_with_args(
                    "src/HorseNFT.huff", bytes.concat(abi.encode(NFT_NAME), abi.encode(NFT_SYMBOL))
                )
            )
        );
    }
}
