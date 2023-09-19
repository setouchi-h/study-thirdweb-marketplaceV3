// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Marketplace
 * @author ...
 */

import {IERC1155Receiver} from "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {InitStorage} from "./InitStorage.sol";

contract Marketplace is IERC1155Receiver, IERC721Receiver {
    bytes32 private constant MODULE_TYPE = bytes32("Marketplace");
    uint256 private constant VERSION = 1;

    constructor(address _pluginMap, address _royaltyEngineAddress)
        RouterImmutable(_pluginMap)
        RoyaltyPaymentsLogic(_royaltyEngineAddress)
    {}
}
