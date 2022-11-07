// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "solmate/tokens/ERC721.sol";
import "solmate/utils/Bytes32AddressLib.sol";

import "./BigStepper.sol";

library LibStepper {
    using Bytes32AddressLib for bytes32;

    function findStepper(ERC721 token, uint256 id, uint256 price, address sellooor) internal view returns (address) {
        return keccak256(
            abi.encodePacked(
                bytes1(0xFF),
                address(this),
                keccak256(abi.encode(price, sellooor)),
                keccak256(abi.encodePacked(type(BigStepper).creationCode, abi.encode(token, id)))
            )
        ).fromLast20Bytes();
    }
}
