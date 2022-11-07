// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "solmate/tokens/ERC721.sol";
import {Bytes32AddressLib} from "solmate/utils/Bytes32AddressLib.sol";

import "./BigStepper.sol";

library LibStepper {
    function findStepper(
        ERC721 token,
        uint256 id,
        uint256 price
    ) internal returns (address) {
        return
            keccak256(
                abi.encodePacked(
                    // Prefix:
                    bytes1(0xFF),
                    // Creator:
                    address(this),
                    // Salt:
                    keccak256(abi.encode(token, id)),
                    // Bytecode hash:
                    keccak256(
                        abi.encodePacked(
                            // Deployment bytecode:
                            type(BigStepper).creationCode,
                            // Constructor arguments:
                            abi.encode(token, id, price)
                        )
                    )
                )
            ).fromLast20Bytes(); // Convert the CREATE2 hash into an address.
    }
}
