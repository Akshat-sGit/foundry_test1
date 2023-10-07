// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract NFTRoyalSplitter is Ownable{
    using SafeMath for uint256; 

    ERC721 public nft; 
    address[] public royaltyRecipients;
    mapping(address => uint256) public royalties; 

    constructor(address _nftAddress){
        nft = ERC721(_nftAddress); 
    }

    function setRoyalties(address _recipient, uint256 _percentage) external onlyOwner{
        require(_recipient != address(0), "Invalid address"); 
        require(_percentage <= 100, "Percentage should be <= 100"); 
        royalties[_recipient] = _percentage;
    }

    function splitRoyalties(uint256 _tokenId, uint256 _salePrice) external onlyOwner{
        require(msg.sender == nft.ownerOf(_tokenId), "You do not own this NFT");
        require(_salePrice > 0, "Sale price should be greater than 0"); 
        uint256 totalRoyalty = 0; 
        for(uint256 i =0; i< royaltyRecipients.length; i++){
            address recipient = royaltyRecipients[i];
            uint256 percentage = royalties[recipient];
            uint256 royaltyAmount = (_salePrice * percentage) /100; 
            require(royaltyAmount > 0, "Royalty amount should be greater than 0");
            payable(recipient).transfer(royaltyAmount);
            totalRoyalty += royaltyAmount; 
        }
        uint256 creatorRoyalty = _salePrice - totalRoyalty; 
        payable(nft.ownerOf(_tokenId)).transfer(creatorRoyalty);
    }



}