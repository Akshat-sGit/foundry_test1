// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../interfaces/IERC20.sol";

contract GaslessTokenTransfer { 
    function send(
        address token,
        address sender,
        address receiver,
        uint amount,
        uint fee,
        uint deadline,
        // Permit signature
        uint8 v,
        bytes32 r,
        bytes32 s
     ) external { 
        IERC20Permit(token).permit(
            sender, address(this), amount + fee, deadline, v, r, s
        );
        // Send amount to receiver
        IERC20Permit(token).transferFrom(sender, receiver, amount);
        // Take fee - send fee to msg.sender 
        IERC20Permit(token).transferFrom(sender, msg.sender, fee);
    }
}