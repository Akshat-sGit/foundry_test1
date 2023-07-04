// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.18;

import "forge-std/Test.sol"; 
import {Auction} from "../src/Time.sol";

contract TimeTest is Test{
    Auction public auction; 
    uint256 private startAt; 

    // vm warp - setUp - test - tearDown - vm unwarp
    function setUp() public {   
        auction = new Auction(); 
        startAt = block.timestamp;     
    }

    function testBidFailsBeforeStartTime() public{ 
        vm.expectRevert(bytes("cannot bid"));
        auction.bid();
    }

    function testBid() public{ 
        vm.warp(startAt + 1 days);
        auction.bid(); 
    }

    function testBidFailsAfterEndTime() public{ 
        vm.expectRevert(bytes("cannot bid"));
        vm.warp(startAt + 2 days);
        auction.bid(); 
    }


    function testTimeStamp() public{ 
        uint t = block.timestamp; 
        skip(100); 
        assertEq(block.timestamp, t +100); 
        rewind(10); 
        assertEq(block.timestamp, t + 100 - 10); 
    }

    function testBlockNumber() public{ 
        // vm roll - set block number
        vm.roll(999); 
        assertEq(block.number, 999);
    }

}