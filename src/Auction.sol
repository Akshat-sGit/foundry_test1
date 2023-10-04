// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract NFTAuction is Ownable{

    ERC721Enumerable public nftContract; 
    uint public auctionEndTime; 
    address public currentHighestBidder; 
    uint public currentHighestBid; 
    mapping(address=>uint256) public bidderBalances; 

    constructor(address _nftContractAddress){
        nftContract = ERC721Enumerable(_nftContractAddress); 
        auctionEndTime = block.timestamp + 7 days; 
    }

    modifier onlyBeforeAuctionEnd(){
        require(block.timestamp < auctionEndTime, "Auction has ended"); 
        _;
    }

    modifier onlyAfterAuctionEnd(){
        require(block.timestamp >= auctionEndTime, "Auction has not ended"); 
        _;
    }

    function placeBid() external payable onlyBeforeAuctionEnd{ 
        require(msg.value > currentHighestBid, "Bid must be higher than the current highest bid");
        if(currentHighestBidder != address(0)){
            bidderBalances[currentHighestBidder] += currentHighestBid; 
        }
        currentHighestBidder = msg.sender; 
        currentHighestBid = msg.value; 
    }



    function withdrawBid() external onlyBeforeAuctionEnd {
        require(msg.sender != currentHighestBidder, "You cannot withdraw the highest bid"); 
        uint bidAmount = bidderBalances[msg.sender]; 
        require(bidAmount > 0, "No bid to wothdraw"); 
        bidderBalances[msg.sender] = 0; 
        payable(msg.sender).transfer(bidAmount);
    }

    

    function endAuction() external onlyAfterAuctionEnd{
        require(msg.sender == currentHighestBidder,"Only the highest bidder can end the auction");
        if(currentHighestBidder != address(0)){
            nftContract.transferFrom(address(this), currentHighestBidder,nftContract.tokenOfOwnerByIndex(address(this), 0));
            payable(owner()).transfer(currentHighestBid); 
        }
        currentHighestBidder = address(0); 
        currentHighestBid = 0; 
    }
}