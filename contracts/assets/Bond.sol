// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20, ERC20Burnable} from '@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

import {Operator} from '../access/Operator.sol';

contract Bond is ERC20Burnable, Operator {
    /**
     * @notice Constructs the Basis Bond ERC-20 contract.
     */
    constructor() ERC20('BAB', 'BAB') Ownable(msg.sender) {
        // Mints 1 Basis Cash to contract creator for initial Uniswap oracle deployment.
        // Will be burned after oracle deployment
        _mint(msg.sender, 1 * 10**18);
    }

    /**
     * @notice Operator mints basis bonds to a recipient
     * @param recipient_ The address of recipient
     * @param amount_ The amount of basis bonds to mint to
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
