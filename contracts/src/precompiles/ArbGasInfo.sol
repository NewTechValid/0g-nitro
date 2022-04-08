// Copyright 2021-2022, Offchain Labs, Inc.
// For license information, see https://github.com/nitro/blob/master/LICENSE
// SPDX-License-Identifier: BUSL-1.1

pragma solidity >=0.4.21 <0.9.0;

/// @title Provides insight into the cost of using the chain.
/// @notice These methods have been adjusted to account for Nitro's heavy use of calldata compression.
/// Of note to end-users, we no longer make a distinction between non-zero and zero-valued calldata bytes.
/// Precompiled contract that exists in every Arbitrum chain at 0x000000000000000000000000000000000000006c.
interface ArbGasInfo {
    /// @notice Get gas prices for a provided aggregator
    /// @return return gas prices in wei
    ///        (
    ///            per L2 tx,
    ///            per L1 calldata unit, (a byte, non-zero or otherwise, is 16 units)
    ///            per storage allocation,
    ///            per ArbGas base,
    ///            per ArbGas congestion,
    ///            per ArbGas total
    ///        )
    function getPricesInWeiWithAggregator(address aggregator)
        external
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256
        );

    /// @notice Get gas prices. Uses the caller's preferred aggregator, or the default if the caller doesn't have a preferred one.
    /// @return return gas prices in wei
    ///        (
    ///            per L2 tx,
    ///            per L1 calldata unit, (a byte, non-zero or otherwise, is 16 units)
    ///            per storage allocation,
    ///            per ArbGas base,
    ///            per ArbGas congestion,
    ///            per ArbGas total
    ///        )
    function getPricesInWei()
        external
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256
        );

    /// @notice Get prices in ArbGas for the supplied aggregator
    /// @return (per L2 tx, per L1 calldata unit, per storage allocation)
    function getPricesInArbGasWithAggregator(address aggregator)
        external
        view
        returns (
            uint256,
            uint256,
            uint256
        );

    /// @notice Get prices in ArbGas. Assumes the callers preferred validator, or the default if caller doesn't have a preferred one.
    /// @return (per L2 tx, per L1 calldata unit, per storage allocation)
    function getPricesInArbGas()
        external
        view
        returns (
            uint256,
            uint256,
            uint256
        );

    /// @notice Get the gas accounting parameters
    /// @return (speedLimitPerSecond, gasPoolMax, maxTxGasLimit)
    function getGasAccountingParams()
        external
        view
        returns (
            uint256,
            uint256,
            uint256
        );

    /// @notice Get the minimum gas price needed for a tx to succeed
    function getMinimumGasPrice() external view returns (uint256);

    /// @notice Get the number of seconds worth of the speed limit the gas pool contains
    function getGasPoolSeconds() external view returns (uint64);

    /// @notice Get the target fullness in bips the pricing model will try to keep the pool at
    function getGasPoolTarget() external view returns (uint64);

    /// @notice Get the extent in bips to which the pricing model favors filling the pool over increasing speeds
    function getGasPoolWeight() external view returns (uint64);

    /// @notice Get ArbOS's estimate of the amount of gas being burnt per second
    function getRateEstimate() external view returns (uint64);

    /// @notice Get how slowly ArbOS updates its estimate the amount of gas being burnt per second
    function getRateEstimateInertia() external view returns (uint64);

    /// @notice Get ArbOS's estimate of the L1 basefee in wei
    function getL1BaseFeeEstimate() external view returns (uint256);

    /// @notice Get how slowly ArbOS updates its estimate of the L1 basefee
    function getL1BaseFeeEstimateInertia() external view returns (uint64);

    /// @notice Deprecated -- Same as getL1BaseFeeEstimate()
    function getL1GasPriceEstimate() external view returns (uint256);

    /// @notice Get L1 gas fees paid by the current transaction
    function getCurrentTxL1GasFees() external view returns (uint256);

    /// @notice Get the amount of gas remaining in the gas pool
    function getGasPool() external view returns (int64);
}