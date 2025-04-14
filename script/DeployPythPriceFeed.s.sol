// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {PythPriceFeed} from "src/PythPriceFeed.sol";

contract DeployPythPriceFeed is Script {
    // Sepolia
    address pythContract = 0xDd24F84d36BF92C65F92307595335bdFab5Bbd21;

    function run() external {
        vm.broadcast();
        PythPriceFeed pythPriceFeed = new PythPriceFeed(pythContract);

        console.log("PythPriceFeed deployed to:", address(pythPriceFeed));
    }
}
