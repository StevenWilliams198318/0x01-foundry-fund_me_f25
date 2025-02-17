// SPDX-License-Identifier: MIT

// Deploy mocks when we are on a local anvil chain

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed; // ETH / USD price feed address
    }

    constructor() {
        if (block.chainid == 1337) {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        } else if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetworkConfig = getMainnetEthConfig();
        } else if (block.chainid == 8453) {
            activeNetworkConfig = getBaseMainnetEthConfig();
        } else if (block.chainid == 84532) {
            activeNetworkConfig = getBaseTestnetEthConfig();
        } else if (block.chainid == 324) {
            activeNetworkConfig = getZKSyncMainnetEthConfig();
        } else if (block.chainid == 300) {
            activeNetworkConfig = getZKSyncTestnetEthConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        // If we cann 'getOrCreateAnvilEthConfig()' without the if statement in it,
        // we will create a price Feed (new MockV3Aggregator contract), rather using the deployed one.

        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
            DECIMALS,
            INITIAL_PRICE
        );
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilConfig;
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getMainnetEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory ethConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return ethConfig;
    }

    //     function getSolanaDevnetEthConfig() public pure returns (NetworkConfig memory) {
    //     NetworkConfig memory DevnetEthConfig = NetworkConfig({
    //         priceFeed: 669U43LNHx7LsVj95uYksnhXUfWKDsdzVqev3V4Jpw3P
    //     });
    //     return DevnetEthConfig;
    // }
    //         function getSolanaMainnetEthConfig() public pure returns (NetworkConfig memory) {
    //     NetworkConfig memory SolanaEthConfig = NetworkConfig({
    //         priceFeed: 716hFAECqotxcXcj8Hs8nr7AG6q9dBw2oX3k3M8V7uGq
    //     });
    //     return SolanaEthConfig;
    // }

    function getBaseMainnetEthConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        NetworkConfig memory BaseEthConfig = NetworkConfig({
            priceFeed: 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70
        });
        return BaseEthConfig;
    }

    function getBaseTestnetEthConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        NetworkConfig memory BaseTestEthConfig = NetworkConfig({
            priceFeed: 0x4aDC67696bA383F43DD60A9e78F2C97Fbbfc7cb1
        });
        return BaseTestEthConfig;
    }

    function getZKSyncMainnetEthConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        NetworkConfig memory ZKSyncEthConfig = NetworkConfig({
            priceFeed: 0x6D41d1dc818112880b40e26BD6FD347E41008eDA
        });
        return ZKSyncEthConfig;
    }

    function getZKSyncTestnetEthConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        NetworkConfig memory ZKSyncTestEthConfig = NetworkConfig({
            priceFeed: 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
        });
        return ZKSyncTestEthConfig;
    }
}
