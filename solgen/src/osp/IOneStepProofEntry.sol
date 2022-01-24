//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./IOneStepProver.sol";

library OneStepProofEntryLib {
    uint256 constant MAX_STEPS = 1 << 43;
}

interface IOneStepProofEntry {
    function proveOneStep(
        ExecutionContext calldata execCtx,
        uint256 machineStep,
        bytes32 beforeHash,
        bytes calldata proof
    ) external view returns (bytes32 afterHash);
}