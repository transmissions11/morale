// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "solmate/tokens/ERC721.sol";
import "solmate/utils/Bytes32AddressLib.sol";

import "./MrMorale.sol";

contract Enoch {
    event MoraleSummoned(MrMorale indexed morale);

    // Reusing MrMorales too frequently runs the risk of getting them blacklisted by
    // contracts who check the warmness of known MrMorale addresses. By using a variety
    // of MrMorale addresses, we can make checking the warmness of all MrMorales infeasible.
    function summonMorale(bytes32 rand) public returns (MrMorale morale) {
        emit MoraleSummoned(morale = new MrMorale{salt: rand}());
    }

    function findStepper(MrMorale morale, ERC721 token, uint256 id, uint256 price, address selloooor)
        public
        pure
        returns (address)
    {
        return Bytes32AddressLib.fromLast20Bytes(
            keccak256(
                abi.encodePacked(
                    bytes1(0xFF),
                    address(morale),
                    keccak256(abi.encode(price, selloooor)),
                    keccak256(abi.encodePacked(type(BigStepper).creationCode, abi.encode(morale, token, id)))
                )
            )
        );
    }
}
