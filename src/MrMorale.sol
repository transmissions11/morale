// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";

import "./BigStepper.sol";

contract MrMorale {
    address public buyoooor;

    function buy(ERC721 token, uint256 id, uint256 price, address selloooor) public payable {
        payable(selloooor).transfer(price);

        buyoooor = msg.sender;
        new BigStepper{salt: keccak256(abi.encode(price, selloooor))}(
            token,
            id
        );
        delete buyoooor;

        // gg no re.
    }

    function delist(ERC721 token, uint256 id, uint256 price) public {
        buyoooor = msg.sender;
        new BigStepper{salt: keccak256(abi.encode(price, msg.sender))}(
            token,
            id
        );
        delete buyoooor;
    }
}
