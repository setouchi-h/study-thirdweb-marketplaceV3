// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import {PlatformFeeStorage} from "./PlatformFeeStorage.sol";
import {IPlatformFee} from "../interface/IPlatformFee.sol";

/**
 *  @author
 *  @title   PlatformFeeLogic
 */

abstract contract PlatformFeeLogic is IPlatformFee {
    error PlatformFeeLogic__NotAuthorized();
    error PlatformFeeLogic__ExceedsMaxBps();

    /// @dev Returns the platform fee recipient and bps.
    function getPlatformFeeInfo() public view override returns (address, uint16) {
        PlatformFeeStorage.Data storage data = PlatformFeeStorage.platformFeeStorage();
        return (data.platformFeeRecipient, uint16(data.platformFeeBps));
    }

    /**
     *  @notice         Updates the platform fee recipient and bps.
     *  @dev            Caller should be authorized to set platform fee info.
     *                  See {_canSetPlatformFeeInfo}.
     *                  Emits {PlatformFeeInfoUpdated Event}; See {_setupPlatformFeeInfo}.
     *
     *  @param _platformFeeRecipient   Address to be set as new platformFeeRecipient.
     *  @param _platformFeeBps         Updated platformFeeBps.
     */
    function setPlatformFeeInfo(address _platformFeeRecipient, uint256 _platformFeeBps) external override {
        if (!_canSetPlatformFeeInfo()) {
            revert PlatformFeeLogic__NotAuthorized();
        }
        _setupPlatformFeeInfo(_platformFeeRecipient, _platformFeeBps);
    }

    /// @dev Lets a contract admin update the platform fee recipient and bps
    function _setupPlatformFeeInfo(address _platformFeeRecipient, uint256 _platformFeeBps) internal {
        PlatformFeeStorage.Data storage data = PlatformFeeStorage.platformFeeStorage();
        if (_platformFeeBps > 10_000) {
            revert PlatformFeeLogic__ExceedsMaxBps();
        }

        data.platformFeeBps = uint16(_platformFeeBps);
        data.platformFeeRecipient = _platformFeeRecipient;

        emit PlatformFeeInfoUpdated(_platformFeeRecipient, _platformFeeBps);
    }

    /// @dev Returns whether platform fee info can be set in the given execution context.
    function _canSetPlatformFeeInfo() internal view virtual returns (bool);
}
