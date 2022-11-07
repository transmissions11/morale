// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";

import "./MrMorale.sol";

MrMorale constant morale = MrMorale(address(0xBEEF)); // TODO

contract BigStepper {
    constructor(ERC721 token, uint256 id) {
        token.transferFrom(address(this), morale.buyoooor(), id);
    }
}
