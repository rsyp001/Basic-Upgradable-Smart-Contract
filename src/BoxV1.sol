// SPDX-License-Identifier: MIT​
pragma solidity ^0.8.18;

contract BoxV1 {
    uint256 private number;

    function getNumber() external view returns (uint256) {
        return number;
    }

    function getVersion() external pure returns (uint256) {
        return 1;
    }
}
