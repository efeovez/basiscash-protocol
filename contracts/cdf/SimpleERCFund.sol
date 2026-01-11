// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

import {Operator} from '../access/Operator.sol';
import {ISimpleERCFund} from './ISimpleERCFund.sol';

contract SimpleERCFund is ISimpleERCFund, Operator {
    using SafeERC20 for IERC20;

    constructor() Ownable(msg.sender) {}

    function deposit(address token_, uint256 amount_, string calldata reason_) public override {
        IERC20(token_).safeTransferFrom(msg.sender, address(this), amount_);
        emit Deposit(token_, msg.sender, amount_, reason_);
    }

    function withdraw(address token_, uint256 amount_, address to_, string calldata reason_) public override onlyOperator {
        IERC20(token_).safeTransfer(to_, amount_);
        emit Withdrawal(token_, msg.sender, to_, amount_, reason_);
    }

    event Deposit(address indexed token_, address indexed from, uint256 amount, string reason);
    event Withdrawal(address indexed token, address indexed from, address indexed to, uint256 amount, string reason);
}
