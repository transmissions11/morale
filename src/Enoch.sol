// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";
import "./LibStepper.sol";
import "./BigStepper.sol";

// i couldnt sleep last night because i felt this shit

contract Enoch {
    address public buyoooor;

    function list(
        ERC721 token,
        uint256 id,
        uint256 price
    ) public {
        address stepper = LibStepper.findStepper(token, id, price);
        token.transferFrom(msg.sender, stepper, id);
    }

    function buy(
        ERC721 token,
        uint256 id,
        uint256 price
    ) public payable {
        require(msg.value >= price);

        buyoooor = msg.sender;
        new BigStepper{salt: keccak256(abi.encode(price))}(token, id);
        delete buyoooor;

        // gg no re.
    }
}
