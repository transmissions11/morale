// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {MockERC721} from "solmate/test/utils/mocks/MockERC721.sol";

contract MockBlacklistERC721 is MockERC721 {
    constructor(string memory _name, string memory _symbol) MockERC721(_name, _symbol) {}

    modifier noContracts(address to) {
        require(msg.sender.code.length == 0 && to.code.length == 0, "CONTRACT");

        _;
    }

    function transferFrom(address from, address to, uint256 tokenId) public override noContracts(to) {
        super.transferFrom(from, to, tokenId);
    }

    function approve(address to, uint256 tokenId) public override noContracts(to) {
        super.approve(to, tokenId);
    }

    function setApprovalForAll(address operator, bool approved) public override noContracts(operator) {
        super.setApprovalForAll(operator, approved);
    }
}
