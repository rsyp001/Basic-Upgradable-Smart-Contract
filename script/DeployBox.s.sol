// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std-script.sol";
import {BoxV1} from "./BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967Proxy.sol";

contract DeployBox is Script {
    function run() external returns (address) {
        address proxy = deployBox();
        return proxy;
    }

    function deployBox() public returns (address) {
        vm.startBroadcast();
        BoxV1 boxV1 = new BoxV1(); //implementation contract
        ERC1967Proxy proxy = new ERC1967Proxy(address(boxV1), "");
        boxV1.initialize(); //initialize the proxy contract
        vm.stopBroadcast();
        return address(proxy);
    }
}
