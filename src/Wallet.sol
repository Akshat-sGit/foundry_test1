// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Wallet{ 
    address payable public owner; 

    event Deposit(address account, uint256 amount); 

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value); 
    }   

    function withdraw(uint256 _amount) external{ 
        require(msg.sender == owner, "Caller is not the owner"); 
        payable(msg.sender).transfer(_amount);
    }

    function setOwner(address _owner) external{ 
        require(msg.sender == owner, "Caller is not the owner"); 
        owner = payable(_owner);
    }

}