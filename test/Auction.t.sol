// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "./../src/Auction.sol";

contract AuctionTest is DSTest {
    NFTAuction auction;

    function setUp() public {
        auction = new NFTAuction(address(this));
    }

    function testPlaceBid() public {
        assertEq(auction.owner(), address(this));
        auction.placeBid();
        uint initialBid = 1;
        uint higherBid = 2;

        auction.placeBid{value: initialBid}();

        assertEq(auction.currentHighestBid, initialBid);

        auction.placeBid{value: higherBid}();

        assertEq(auction.currentHighestBidder, address(this));
        assertEq(auction.currentHighestBid, higherBid);
    }
}