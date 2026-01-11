// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISimpleERCFund {
    function deposit(address token_, uint256 amount_, string calldata reason_) external;

    function withdraw(address token_, uint256 amount_, address to_, string calldata reason_) external;
}
