// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgrade is Test {
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public OWNER = makeAddr("owner");

    address public proxy;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();

        proxy = deployer.run(); //points to V1
    }

    function testUpgrade() public {
        BoxV2 boxV2 = new BoxV2();

        upgrader.upgradeBox(proxy, address(boxV2)); //points to V2

        uint256 expectedValue = 2;
        assert(expectedValue == BoxV2(proxy).getVersion());

        BoxV2(proxy).setNumber(42);
        assertEq(42, BoxV2(proxy).getNumber());
    }

    function testProxyStartAsBoxV1() public {
        uint256 expectedValue = 1;
        assert(expectedValue == BoxV1(proxy).version());

        vm.expectRevert();
        BoxV2(proxy).setNumber(22);
    }
}
