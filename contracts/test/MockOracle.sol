// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../oracle/Oracle.sol';

contract MockOracle is IOracle {
    uint256 epoch;
    uint256 period;

    uint256 public price;
    bool public error;

    uint256 startTime;

    constructor() {
        startTime = block.timestamp;
    }

    // epoch
    function callable() public pure returns (bool) {
        return true;
    }

    function setEpoch(uint256 _epoch) public {
        epoch = _epoch;
    }

    function setStartTime(uint256 _startTime) public {
        startTime = _startTime;
    }

    function setPeriod(uint256 _period) public {
        period = _period;
    }

    function getLastEpoch() public view returns (uint256) {
        return epoch;
    }

    function getCurrentEpoch() public view returns (uint256) {
        return epoch;
    }

    function getNextEpoch() public view returns (uint256) {
        return epoch + 1;
    }

    function nextEpochPoint() public view returns (uint256) {
        return startTime + (getNextEpoch() * period);
    }

    // params
    function getPeriod() public view returns (uint256) {
        return period;
    }

    function getStartTime() public view returns (uint256) {
        return startTime;
    }

    function setPrice(uint256 _price) public {
        price = _price;
    }

    function setRevert(bool _error) public {
        error = _error;
    }

    function update() external override {
        require(!error, 'Oracle: mocked error');
        emit Updated(0, 0);
    }

    function consult(address, uint256 amountIn)
        external
        view
        override
        returns (uint256)
    {
        return price * amountIn / 1e18;
    }

    event Updated(uint256 price0CumulativeLast, uint256 price1CumulativeLast);
}
