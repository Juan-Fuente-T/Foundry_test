// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "lib/forge-std/src/Test.sol";
import "../src/Bank.sol";
import {Attacker, IBank} from "../src/Attacker.sol";

contract ReentrancyTest is Test {
    // Contratos con los que vamos a interactuar
    Attacker public attacker;
    Bank public bank;

    address public alice;

    function setUp() public {
        bank = new Bank(); // hacemos deploy del contrato bank
        vm.deal(address(bank), 10 ether); // el banco pasa a tener 10 ethers
        assertEq(address(bank).balance, 10 ether); // checkeamos que el balance del banco sea de 10 ethers

        alice = makeAddr("alice"); // creamos la direccion de alice

        vm.startPrank(alice);
        vm.deal(alice, 10 ether); // alice pasa a tener 10 ethers
        assertEq(alice.balance, 10 ether);

        attacker = new Attacker(IBank(address(bank))); // hacemos deploy del attacker
    }

    function testAttack() public {
        attacker.attack{value: 1 ether}(alice);
        assertEq(alice.balance, 20 ether); // comprobamos que alice tenga 20 ethers
    }

    
}
