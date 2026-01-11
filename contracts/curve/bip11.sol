// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Math} from '@openzeppelin/contracts/utils/math/Math.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

import {Operator} from '../access/Operator.sol';
import {Curve} from './Curve.sol';

contract BIP11 is Operator, Curve {
    /* ============= STATE VARIABLES ============= */

    uint256[42] private slots;

    /* ============= CONSTRUCTOR ============= */

    constructor(uint256 minSupply_, uint256 maxSupply_, uint256 minCeiling_, uint256 maxCeiling_) Ownable(msg.sender) {
        minSupply = minSupply_; // minimum price == 0
        maxSupply = maxSupply_; // maximum price == 1
        minCeiling = minCeiling_; // minimum ceiling == 0
        maxCeiling = maxCeiling_; // maximum ceiling == 0

        slots[0] = 254991593906910240;
        slots[1] = 255656216913953120;
        slots[2] = 256409333446256384;
        slots[3] = 257262726279814880;
        slots[4] = 258229747049020032;
        slots[5] = 259325525137728320;
        slots[6] = 260567204383852672;
        slots[7] = 261974211300803616;
        slots[8] = 263568559012200928;
        slots[9] = 265375191655021440;
        slots[10] = 267422374639493536;
        slots[11] = 269742136871492800;
        slots[12] = 272370771856165600;
        slots[13] = 275349405522724960;
        slots[14] = 278724639654239424;
        slots[15] = 282549280989103488;
        slots[16] = 286883167401240032;
        slots[17] = 291794104084919936;
        slots[18] = 297358924391140992;
        slots[19] = 303664691912730176;
        slots[20] = 310810062625218048;
        slots[21] = 318906828394662656;
        slots[22] = 328081666001153216;
        slots[23] = 338478119042087424;
        slots[24] = 350258843722803840;
        slots[25] = 363608153670763840;
        slots[26] = 378734903587804416;
        slots[27] = 395875756856227584;
        slots[28] = 415298888221586752;
        slots[29] = 437308179481957312;
        slots[30] = 462247973826743424;
        slots[31] = 490508463208342656;
        slots[32] = 522531793034013184;
        slots[33] = 558818979688020544;
        slots[34] = 599937749111156096;
        slots[35] = 646531419074993792;
        slots[36] = 699328964117222656;
        slots[37] = 759156420607550464;
        slots[38] = 826949810380488320;
        slots[39] = 903769785129849216;
        slots[40] = 990818220681719680;
        slots[41] = 1015797020769208960;
    }

    /* ============= GOVERNANCE ============= */

    function setMinSupply(uint256 newMinSupply_) public override onlyOperator {
        super.setMinSupply(newMinSupply_);
    }

    function setMaxSupply(uint256 newMaxSupply_) public override onlyOperator {
        super.setMaxSupply(newMaxSupply_);
    }

    function setMinCeiling(uint256 newMinCeiling_) public override onlyOperator {
        super.setMinCeiling(newMinCeiling_);
    }

    function setMaxCeiling(uint256 newMaxCeiling_) public override onlyOperator {
        super.setMaxCeiling(newMaxCeiling_);
    }

    /* ========== VIEW FUNCTIONS ========== */

    function calcCeiling(uint256 price_) public view override returns(uint256) {
        if (price_ <= minSupply) {
            return minCeiling;
        }
        if (price_ >= maxSupply) {
            return maxCeiling;
        }

        uint256 slotWidth = (maxSupply - minSupply) / (slots.length - 1);
        uint256 xa = (price_ - minSupply) / slotWidth;

        if (xa > slots.length - 2) {
            xa = slots.length - 2;
        }

        uint256 xb = xa + 1;

        uint256 slope = (slots[xb] - slots[xa]) * 1e18 / slotWidth;
        uint256 x = slope * (slotWidth * xa) / 1e18;
        uint256 y = slots[xa];

        uint256 wy = 0;
        uint256 percentage = 0;

        if (x > y) {
            wy = x - y;
            percentage = slope * price_ / 1e18 - wy;
        } else {
            wy = y - x;
            percentage = slope * price_ / 1e18;
        }

        return minCeiling + ((maxCeiling - minCeiling) * percentage / 1e18);
    }
}
