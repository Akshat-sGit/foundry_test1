// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

contract ConsoleTest is Test {
    function testLogSomething() public view {
        console.log("log something here", 123);
        int x = -1; 
        console.logInt(x);
    }
}