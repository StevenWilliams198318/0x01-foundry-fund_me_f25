// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        /**
         * Anything before the 'vm.startBroadcast()' and after the 'vm.stopBroadcast()' is not broadcasted to the blockchain as real tx (gas notUsed)
         * Anything inbetween 'vm.startBroadcast()' and 'vm.stopBroadcast()' is broadcasted to the blockchain as real tx (gas Used)
         */
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeedAddress = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeedAddress);
        vm.stopBroadcast();
        return fundMe;
    }
}

/* Creating a Mock contract.
We will deploy a fake priceFeed contract on our local 'anvil' network to be used as our
Chainlink PriceFeed contract. */
