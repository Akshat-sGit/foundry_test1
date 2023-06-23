// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Wallet{ 
    address payable public owner; 

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {}   

    function withdraw(uint256 _amount) external{ 
        require(msg.sender == owner, "Caller is not the owner"); 
        payable(msg.sender).transfer(_amount);
    }

    function setOwner(address _owner) external{ 
        require(msg.sender == owner, "Caller is not the owner"); 
        owner = payable(_owner);
    }
}