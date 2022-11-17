// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";

import "./MrMorale.sol";

contract BigStepper {
    constructor(MrMorale morale, address selloooor, ERC721 token, uint256 id) {
        token.transferFrom(selloooor, morale.buyoooor(), id);
    }
}
