// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";
import "./Enoch.sol";

// Transformation, I must had a thousand lives and like three thousand wives

Enoch constant ENOCH = Enoch(address(0xBEEF)); // TODO

contract BigStepper {
    constructor(ERC721 token, uint256 id) {
        token.transferFrom(address(this), ENOCH.buyoooor(), id);
    }
}
