// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";
import "./LibRLP.sol";

// i couldnt sleep last night because i felt this shit

contract Enoch {
    function list(ERC721 token, uint256 id) public {
        token.transferFrom(msg.sender, id);
    }
}
