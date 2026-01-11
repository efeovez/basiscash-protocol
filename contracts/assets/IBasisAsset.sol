// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';

interface IBasisAsset is IERC20 {
    function mint(address recipient_, uint256 amount_) external;

    function burn(uint256 amount_) external;

    function burnFrom(address account_, uint256 amount_) external;

    function isOperator() external returns(bool);

    function getOperator() external view returns(address);
}
