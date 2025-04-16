// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {PythPriceFeed} from "src/PythPriceFeed.sol";
import {Vm} from "forge-std/Vm.sol";
import {PythStructs} from "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";

contract GetETHUSDPrice is Script {
    PythPriceFeed pythPriceFeed;

    function run() external {
        address pythContract = Vm(address(vm)).getDeployment(
            "PythPriceFeed",
            uint64(block.chainid)
        );

        console.log("Pyth Contract Address: ", pythContract);

        pythPriceFeed = PythPriceFeed(payable(pythContract));
        bytes[] memory priceUpdate = new bytes[](1);
        priceUpdate[
            0
        ] = "0x504e41550100000003b801000000040d001be65f950c7e74315871b09924b7523b12e0d55d59f74328f03e3bae63fff41764863180937dc343804f3a2b3a1486ebe4bafd138a001ab4c41ca3e000230bc2010248543fd3aec5bf170c4bf40294668b2014d3bede70fb8221cfcc398873ba8713388e67bf9fb6037ada66199d033ebd57e8c477fd7b63c39c25e764d3a59a007b0103090306f26bac8b2ae4a5b71e72b2ec05e1c0fe147bb1a11591f1ade944974f461a167e571ad104aa0bbec90ce08a3ea0f9053614f88c37a25b91c63ff6377fca010457fd79ff90b2d02f5ab77f2245eaa92a58947f712679ca8ede10af79d35c9bd707e52600b8660140493276949979db9d16826d234eb53a041e442f19c24db0bb0008d17096a745998d9f739ed356be7d1042ae05a586e6d57b19c1c3305862d6f0e122b9ecc894e147a542e9ad4aabb1024ee02bcdbe0a84f765f0758b4a692f9c9f000a1c99819afe97c4655f86b35f3c5f451a8ab042927d747f1876b59bdd696c8e612b3872686af7df372a5e785b559564b20d91408f11bdfe8cda858576bc024e1b010b44acbe6f1c0c0d539c57b717f9b56859365cc9baa9603409fe0a1eb815636d403eff5e00f5805ca0d590eb985ea55e25d11bdef583662bdc65da268b3b0bf024010c33bf5d67ce06b2a00602a70a1754b08372730b3b9988388e92c937bcfdfeb61c223ec7be85c91f96c841f3534987984935f233c8349063a89444762a5925ffb2010d525ad62046bda30b812b28532c3b7a2f79ef2068c1b5325a3b910e0030e932d438da2ac4b777fde02abd423134ca94efbb9e482ade95cf2a4929010c3e604cda000e443d953f0e7814b941e0397e24631884a83fb28b6d3a22d1e343576ea1f19ec80c06046a2058605924c7ff7fa02225b461b2a960a2226fa583df1d80eef0036a000f49eff9cff4722c45fbfd43add1c1f9be948f34b036f648b8b9fef68cebf16ca461646ad31fca456be6a10670f9d8f6a3238049940058b7570a6a9bcfc07da4ba01103054a83a844e269e1857f617086086212ed8944f4a8969e6c57f1e024d46e62a1fe2f8d1c2575f70e65dee616ee632180f5d448c18814f36fe7b6ed405f1872300113cfbeb0a848fefb779afa897b842aaeeac71acc426534f76cdfd1ce67d649f470f8939467ee6486d9020a8183bf986091cb652b33a3b8f9fa9926f6ed05b986d0167fe728900000000001ae101faedac5851e32b9b23b5f9411a8c2bac4aae3ed4dd7b811dd1a72ea4aa710000000007826eef014155575600000000000c8fe84900002710415b2970179ee98a7848d9792ff6336aa1f6a18101005500ff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace00000025c9efe3f60000000007274e82fffffff80000000067fe72890000000067fe728900000025f0dd223000000000065823d50cd008109d5d5cd80f064bfb1e4d75e1200055ab553335262de2c7cb574d7224a99787316c584bdd7a6b360005072cb8c7c7acd52ad24c19ae1c71794cc35ea47f960d3960d531e2ab8c0b0b93d6a757208b17be7ad6fac79a8baeb94ceee231698a1ca94ea5691c8d853176e034e45b29ac0f84887ce676f9899985617a98b7403e3dae1d25da5fec75dd13811b691eff03975d359bc6c860189c5e62acb6edce0810df0a8598dd3913d9cbd42de6951787461f12e3d32b34aedfad646d075819989d877b5e1e7e7dd3efa34ee381eeaea7391f2ce04b957afdcec1e3f3517af50d341089de51bca21b21090fc7a17ae8";

        vm.startBroadcast();
        PythStructs.Price memory price = pythPriceFeed.getEThUSDPrice(
            priceUpdate
        );
        vm.stopBroadcast();
        console.log("ETH/USD Price: ", price.price);
    }
}
