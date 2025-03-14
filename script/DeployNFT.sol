// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {NFTSatu} from "../src/NFTSatu.sol";
import "forge-std/console.sol";

contract DeployNFT is Script {
    function run() external {
        vm.startBroadcast();
        
        NFTSatu nft = new NFTSatu();
        
        console.log("NFTSatu deployed at:", address(nft));
        
        vm.stopBroadcast();
    }
}
