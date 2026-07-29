// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {HorseNFT, IHorseNFT} from "../../src/HorseNFT.sol";
import {Test, console2} from "forge-std/Test.sol";

abstract contract HorseNFTBaseTest is Test {
    HorseNFT horseNft;
    address user = makeAddr("user");
    string public constant NFT_NAME = "HorseNFT";
    string public constant NFT_SYMBOL = "HNFT";

    function setUp() public virtual {
        horseNft = new HorseNFT();
    }

    function testName() public view {
        string memory name = horseNft.name();
        assertEq(name, NFT_NAME);
    }

    function testGetTotalSupply() public view {
        uint256 supply = horseNft.totalSupply();
        assertEq(supply, 0);
    }

    function testMintingHorseAssignsOwner(address randomOwner) public {
        vm.assume(randomOwner != address(0));
        vm.assume(!_isContract(randomOwner));

        uint256 horseId = horseNft.totalSupply();
        vm.prank(randomOwner);
        horseNft.mintHorse();
        assertEq(horseNft.ownerOf(horseId), randomOwner);
    }

    function testFeedingHorseUpdatesTimestamps() public {
        uint256 horseId = horseNft.totalSupply();
        vm.warp(10);
        vm.roll(10);
        vm.prank(user);
        horseNft.mintHorse();

        uint256 lastFedTimeStamp = block.timestamp;
        horseNft.feedHorse(horseId);

        assertEq(horseNft.horseIdToFedTimeStamp(horseId), lastFedTimeStamp);
    }

    function testFeedingMakesHappyHorse() public {
        uint256 horseId = horseNft.totalSupply();
        vm.warp(horseNft.HORSE_HAPPY_IF_FED_WITHIN());
        vm.roll(horseNft.HORSE_HAPPY_IF_FED_WITHIN());
        vm.prank(user);
        horseNft.mintHorse();
        horseNft.feedHorse(horseId);
        assertEq(horseNft.isHappyHorse(horseId), true);
    }

    function testNotFeedingMakesUnhappyHorse() public {
        uint256 horseId = horseNft.totalSupply();
        vm.warp(horseNft.HORSE_HAPPY_IF_FED_WITHIN());
        vm.roll(horseNft.HORSE_HAPPY_IF_FED_WITHIN());
        vm.prank(user);
        horseNft.mintHorse();
        assertEq(horseNft.isHappyHorse(horseId), false);
    }

    function testHorseIsHappyIfFedWithinPast24Hours(uint256 horseId, uint256 checkAt) public {
        uint256 fedAt = horseNft.HORSE_HAPPY_IF_FED_WITHIN();
        checkAt = bound(checkAt, fedAt + 1 seconds, fedAt + horseNft.HORSE_HAPPY_IF_FED_WITHIN() - 1 seconds);
        vm.warp(fedAt);
        horseNft.feedHorse(horseId);

        vm.warp(checkAt);
        assertEq(horseNft.isHappyHorse(horseId), true);
    }

    /*//////////////////////////////////////////////////////////////
                            HELPER FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    // Borrowed from an Old Openzeppelin codebase
    function _isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}
