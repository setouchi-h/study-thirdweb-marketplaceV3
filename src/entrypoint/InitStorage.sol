// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/**
 * @author  ...
 */
library InitStorage {
    /// @dev The location of the storage of the entrypoint contract's data.
    bytes32 constant INIT_STORAGE_POSITION = keccak256("init.storage");

    /// @dev Layout of the entrypoint contract's storage.
    struct Data {
        bool initialized;
    }

    /// @dev Returns the entrypoint contract's data at the relevant storage location.
    function initStorage() internal pure returns (Data storage initData) {
        bytes32 position;
        assembly {
            initData.slot := position
        }
    }
}
