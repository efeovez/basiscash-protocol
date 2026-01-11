// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Context, Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

abstract contract Operator is Context, Ownable {
    address public operator;

    event OperatorTransferred(address indexed previousOperator, address indexed newOperator);

    constructor() {
        operator = msg.sender;
        emit OperatorTransferred(address(0), operator);
    }

    modifier onlyOperator() {
        if(operator != msg.sender) {
            revert CallerIsNotTheOperator();
        }
        _;
    }

    function isOperator() public view returns(bool) {
        return msg.sender == operator;
    }

    function transferOperator(address newOperator_) public onlyOwner {
        _transferOperator(newOperator_);
    }

    function _transferOperator(address newOperator_) internal {
        if(newOperator_ == address(0)) {
            revert ZeroAddressGivenForNewOperator();
        }

        address previousOperator = operator;
        operator = newOperator_;
        emit OperatorTransferred(previousOperator, newOperator_);
    }

    function getOperator() public view returns(address) {
        return operator;
    }

    error CallerIsNotTheOperator();
    error ZeroAddressGivenForNewOperator();
}
