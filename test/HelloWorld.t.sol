// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/HelloWorld.sol";

contract HelloworldTest is Test {
    Helloworld public hello;

    function setUp() public {
        hello = new Helloworld();
    }

    function testGreet() public {
        assertEq(hello.greet(), "Hello World!");
    }
}