// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "forge-std/Test.sol";
import {Enoch} from "../src/Enoch.sol";
import {MrMorale} from "../src/MrMorale.sol";
import {MockERC721} from "solmate/test/utils/mocks/MockERC721.sol";

contract MrMoraleTest is Test {
    // I spend most of my days with fleeting thoughts. Writing. Listening.
    Enoch enoch;
    MrMorale morale;

    MockERC721 erc721A;
    MockERC721 erc721B;

    address addr1 = address(0x600DDAD);
    address addr2 = address(0xBADDAD);

    function setUp() public {
        enoch = new Enoch();
        morale = enoch.summonMorale();
        erc721A = new MockERC721("A", "A");
        erc721A = new MockERC721("B", "B");

        erc721A.mint(addr1, 1);
        vm.deal(addr1, 100 ether);
        vm.deal(addr2, 100 ether);
    }

    function testTransferWorks() public {
        uint256 price = 100;
        uint256 tokenId = 1;

        address stepperAddr = enoch.findStepper(morale, erc721A, tokenId, price, addr1);

        vm.prank(addr1);
        erc721A.transferFrom(addr1, stepperAddr, tokenId);
        assertEq(erc721A.ownerOf(tokenId), stepperAddr);

        uint256 balanceBefore = addr1.balance;

        vm.prank(addr2);
        morale.buy{value: price}(erc721A, tokenId, price, addr1);

        uint256 balanceAfter = addr1.balance;

        assertEq(balanceBefore, balanceAfter - price);

        assertEq(erc721A.ownerOf(tokenId), addr2);
    }
}
