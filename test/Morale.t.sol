// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "forge-std/Test.sol";

import {MockBlacklistERC721} from "./mocks/MockBlacklistERC721.sol";

import {Enoch} from "../src/Enoch.sol";
import {MrMorale} from "../src/MrMorale.sol";

contract MoraleTest is Test {
    Enoch enoch;
    MrMorale morale;

    MockBlacklistERC721 erc721A;
    MockBlacklistERC721 erc721B;

    address addr1 = address(0x600DDAD);
    address addr2 = address(0xBADDAD);

    function setUp() public {
        enoch = new Enoch();
        morale = enoch.summonMorale(bytes32(0));

        erc721A = new MockBlacklistERC721("A", "A");
        erc721A = new MockBlacklistERC721("B", "B");

        erc721A.mint(addr1, 1);

        vm.deal(addr1, 100 ether);
        vm.deal(addr2, 100 ether);
    }

    function testPurchase() public {
        uint256 price = 100;
        uint256 id = 1;

        address stepper = enoch.findStepper(morale, erc721A, id, price, addr1);

        vm.prank(addr1);
        erc721A.approve(stepper, id);
        assertEq(erc721A.ownerOf(id), addr1);
        assertEq(erc721A.getApproved(id), stepper);

        uint256 balanceBefore = addr1.balance;

        vm.prank(addr2);
        morale.buy{value: price}(erc721A, id, price, addr1);

        uint256 balanceAfter = addr1.balance;

        assertEq(balanceBefore, balanceAfter - price);

        assertEq(erc721A.ownerOf(id), addr2);
        assertEq(erc721A.getApproved(id), address(0));
    }
}
