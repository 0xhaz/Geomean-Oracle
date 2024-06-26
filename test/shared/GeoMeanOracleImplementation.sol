// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {BaseHook} from "v4-periphery/BaseHook.sol";
import {IPoolManager} from "@uniswap/v4-core/src/interfaces/IPoolManager.sol";
import {Hooks} from "@uniswap/v4-core/src/libraries/Hooks.sol";
import {GeoMeanOracle} from "src/GeomeanOracle.sol";

contract GeomeanOracleImplementation is GeoMeanOracle {
    uint32 public time;

    constructor(IPoolManager _poolManager, GeoMeanOracle addressToEtch) GeoMeanOracle(_poolManager) {
        Hooks.validateHookPermissions(addressToEtch, getHookPermissions());
    }

    // make this a no-op in testing
    function validateHookAddress(BaseHook _this) internal pure override {}

    function setTime(uint32 _time) external {
        time = _time;
    }

    function _blockTimestamp() internal view override returns (uint32) {
        return time;
    }
}
