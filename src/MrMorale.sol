// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";

import "./BigStepper.sol";

contract MrMorale {
    address public buyoooor;

    function buy(ERC721 token, uint256 id, uint256 price, address selloooor) public payable {
        payable(selloooor).transfer(price);

        buyoooor = msg.sender;
        new BigStepper{salt: keccak256(abi.encode(price))}(
            this,
            selloooor,
            token,
            id
        );
        delete buyoooor;

        // gg no re.
    }

    // Normally, to delist you can simply revoke approval from the stepper.
    // However in case you have some sort of public permit approval to the
    // stepper that you have no way to revoke, you can use this function to
    // transfer the token to yourself and brick the stepper contract forever.
    function brick(ERC721 token, uint256 id, uint256 price) public {
        buyoooor = msg.sender;
        new BigStepper{salt: keccak256(abi.encode(price))}(
            this,
            msg.sender,
            token,
            id
        );
        delete buyoooor;
    }
}
