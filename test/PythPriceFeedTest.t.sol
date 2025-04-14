// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {PythPriceFeed} from "src/PythPriceFeed.sol";
import {MockPyth} from "@pythnetwork/pyth-sdk-solidity/MockPyth.sol";
import {PythStructs} from "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";

contract PythPriceFeedTest is Test {
    MockPyth public mockPyth;
    PythPriceFeed public pythPriceFeed;
    uint256 validTimePeriod = 60;
    uint256 singleUpdateFeeInWei = 0.001 ether;

    function setUp() external {
        // Deploy the mock Pyth contract
        mockPyth = new MockPyth(validTimePeriod, singleUpdateFeeInWei);
        // Deploy the PythPriceFeed contract with the mock Pyth address
        pythPriceFeed = new PythPriceFeed(address(mockPyth));
        vm.deal(address(pythPriceFeed), 100 ether);
    }

    function testPythPriceFeedWorking() external {
        // Just dummy data to test the function
        bytes32 id = bytes32(
            0xff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace
        );
        int64 price = 100;
        uint64 conf = 1;
        int32 expo = 0;
        int64 emaPrice = 100;
        uint64 emaConf = 1;
        uint64 publishTime = uint64(block.timestamp);
        uint64 prevPublishTime = uint64(block.timestamp) - 1;

        bytes memory priceFeedData = mockPyth.createPriceFeedUpdateData(
            id,
            price,
            conf,
            expo,
            emaPrice,
            emaConf,
            publishTime,
            prevPublishTime
        );

        bytes[] memory priceUpdate = new bytes[](1);
        priceUpdate[0] = priceFeedData;

        PythStructs.Price memory priceData = pythPriceFeed.getEThUSDPrice(
            priceUpdate
        );

        // Check that the price is updated correctly
        assertEq(priceData.price, price);
    }
}
