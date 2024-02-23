// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract KingOfEther {
    address public king; //por degecto 0x00000000...
    uint256 balance; //por defecto 0

    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more to became the King");

        (bool sent,) = king.call{value: balance}("");
        require(sent, "Failed to send ether");

        balance = msg.value; //se actualiza el balance
        king = msg.sender; //se actualiza el king
    }
}
