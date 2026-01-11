// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20, ERC20Burnable} from '@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

import {Operator} from '../access/Operator.sol';

contract ShareV2 is ERC20Burnable, Operator {
    /**
     * @notice Constructs the Basis Cash ERC-20 contract.
     */
    constructor() ERC20('BASv2', 'BASv2') Ownable(msg.sender) {}

    /**
     * @notice Operator mints basis cash to a recipient
     * @param recipient_ The address of recipient
     * @param amount_ The amount of basis cash to mint to
     */
    function mint(address recipient_, uint256 amount_) public onlyOperator {
        _mint(recipient_, amount_);
    }

    function burn(uint256 amount_) public override onlyOperator {
        super.burn(amount_);
    }

    function burnFrom(address account_, uint256 amount_) public override onlyOperator {
        super.burnFrom(account_, amount_);
    }
}
