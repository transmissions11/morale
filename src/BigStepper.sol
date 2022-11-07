// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";

import "./MrMorale.sol";

contract BigStepper {
    MrMorale constant morale = MrMorale(address(0xBEEF)); // TODO

    constructor(ERC721 token, uint256 id) {
        token.transferFrom(address(this), morale.buyoooor(), id);
    }
}
