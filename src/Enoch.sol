// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";
import "./LibStepper.sol";
import "./BigStepper.sol";

// i couldnt sleep last night because i felt this shit

contract Enoch {
    address public buyoooor;

    mapping(ERC721 => mapping(uint256 => mapping(uint256 => address))) sellooors;

    function delist(ERC721 token, uint256 id, uint256 price) public {
        address sellooor = sellooors[token][id][price];
        require(msg.sender == sellooor, "not bussin");

        buyoooor = msg.sender;
        new BigStepper{salt: keccak256(abi.encode(price))}(token, id);
        delete buyoooor;
    }

    function list(ERC721 token, uint256 id, uint256 price) public {
        address stepper = LibStepper.findStepper(token, id, price);
        sellooors[token][id][price] = msg.sender;
        token.transferFrom(msg.sender, stepper, id);
    }

    function buy(ERC721 token, uint256 id, uint256 price) public payable {
        require(msg.value >= price);

        payable(sellooors[token][id][price]).transfer(msg.value);

        buyoooor = msg.sender;
        new BigStepper{salt: keccak256(abi.encode(price))}(token, id);
        delete buyoooor;

        // gg no re.
    }
}
