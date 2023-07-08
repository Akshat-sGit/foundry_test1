// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/ERC20Permit.sol";
import "../src/app/GaslessTokenTransfer.sol";

contract GaslessTokenTransfer is Test{ 
    ERC20Permit private token;
    GaslessTokenTransfer private gasless;

    uint constant Sender_private_key = 123; 

    address sender; 
    address receiver;
    uint constant AMOUNT = 1000;
    uint constant FEE = 10;


    function setUp() public{ 
        sender = vm.addr(Sender_private_key);
        receiver = address(2);

        token = new ERC20Permit("test", "test", 18); 
        token.mint(sender, AMOUNT + FEE); 

        gasless = new GaslessTokenTransfer();
    }

    function testValidSig() public{ 
        // prepare permit message 
        // execute send 
        // check token balances 
        
    }


}