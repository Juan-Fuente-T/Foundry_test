// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Bank{

    mapping(address => uint256) public balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    function withdraw() public{
        uint256 bal = balances[msg.sender];//balances[attacker] = 1 eth
        require(bal > 0, "No tienes balance");

        (bool sent,) = msg.sender.call{value: bal}(""); //transferimos el ether
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
}

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }
    
}