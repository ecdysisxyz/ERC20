// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

library Schema {
    /// @custom:storage-location erc7201:ecdysisxyz.erc20.globalstate
    struct GlobalState {
        string name;
        string symbol;
        uint8 decimals;
        uint256 totalSupply;
        mapping(address => uint256) balances;
        mapping(address => mapping(address => uint256)) allowances;
    }
}
