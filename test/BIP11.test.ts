import { expect } from "chai";
import { ethers } from "hardhat";
import { SignerWithAddress } from "@nomicfoundation/hardhat-ethers/signers";
import {BIP11} from "../typechain-types";

describe("BIP 11 Test", function() {
    let bip11: BIP11;
    let operator: SignerWithAddress;

    const MIN_PRICE = 0;
    const MAX_PRICE = ethers.parseUnits("1", 18);
    const MIN_RATE = ethers.parseUnits("0.25", 18);
    const MAX_RATE = ethers.parseUnits("1", 18);

    before(async() => {
        [operator] = await ethers.getSigners();

        const Bip11Factory = await ethers.getContractFactory("BIP11");
        bip11 = await Bip11Factory.deploy(MIN_PRICE, MAX_PRICE, MIN_RATE, MAX_RATE);
    });

    it("Should work correctly", async() => {
        const iter = 1000n;
        const minPriceBI = BigInt(MIN_PRICE);
        const maxPriceBI = BigInt(MAX_PRICE);
        const width = (maxPriceBI - minPriceBI) / iter;

        for(let i = 0n; i <= iter; i++) {
            const currentPrice = minPriceBI + (width * i);            
            const rate = await bip11.calcCeiling(currentPrice);
            
            console.log(
                ethers.formatEther(currentPrice), 
                "->", 
                ethers.formatEther(rate)
            );
        }
    });
});
