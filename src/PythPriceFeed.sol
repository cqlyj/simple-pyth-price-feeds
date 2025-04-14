// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {IPyth} from "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import {PythStructs} from "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";

contract PythPriceFeed {
    IPyth pyth;
    // Each price feed (e.g., ETH/USD) is identified by a price feed ID.
    // The complete list of feed IDs is available at https://pyth.network/developers/price-feed-ids
    bytes32 constant ETH_USD_PRICE_ID =
        0xff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace;
    uint constant AGE = 60;

    constructor(address pythContract) {
        pyth = IPyth(pythContract);
    }

    /**
     * Fetch the priceUpdate from Hermes and pass it to the Pyth contract to update the prices.
     * Add the priceUpdate argument to any method on your contract that needs to read the Pyth price.
     * See https://docs.pyth.network/price-feeds/fetch-price-updates for more information on how to fetch the priceUpdate.
 
     * @param priceUpdate The encoded data to update the contract with the latest price
     */
    function getEThUSDPrice(
        bytes[] calldata priceUpdate
    ) public payable returns (PythStructs.Price memory) {
        // Submit a priceUpdate to the Pyth contract to update the on-chain price.
        // Updating the price requires paying the fee returned by getUpdateFee.
        // WARNING: These lines are required to ensure the getPriceNoOlderThan call below succeeds. If you remove them, transactions may fail with "0x19abf40e" error.
        uint fee = pyth.getUpdateFee(priceUpdate);
        pyth.updatePriceFeeds{value: fee}(priceUpdate);

        // Read the current price from a price feed if it is less than 60 seconds old.
        PythStructs.Price memory price = pyth.getPriceNoOlderThan(
            ETH_USD_PRICE_ID,
            AGE
        );

        return price;
    }
}
