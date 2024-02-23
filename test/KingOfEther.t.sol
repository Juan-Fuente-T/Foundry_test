// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "../lib/forge-std/src/Test.sol";
import {AttackerKingOfEther} from "../src/AttackerKingOfEther.sol";
import {KingOfEther} from "../src/KingOfEther.sol";

/**
 * PASOS PARA TESTEAR:
 * 1. Importar y heredar del contrato Test
 * 2. Importar y declarar la/s variable/s mi/s contrato/s que quiero testear
 * 3. Crear una función de setUp (OBLIGATORIO)
 *     3.1 Deployar mis contratos
 *     3.2 (OPCIONAL) Configurar mis contratos (solo si lo necesito)
 * 4. Crear mis funciones de test (tantas como yo quiera)
 */

contract KingOfEtherTest is Test {
    KingOfEther public kingOfEther;

    /// variable de tipo kingOfEther
    AttackerKingOfEther public attackerKingOfEther;
    address public alice;

    function setUp() public {
        /// Siempre se ejecutará la primera
        kingOfEther = new KingOfEther();
        /// deployar el contrato Counter
        attackerKingOfEther = new AttackerKingOfEther(address(kingOfEther));
        /// darle un valor de 10 al number del contrato Counter

        alice = makeAddr("alice");

        vm.startPrank(alice);
        vm.deal(alice, 10 ether);
        assertEq(alice.balance, 10 ether);
    }

    function testKingOfEther() public {
        kingOfEther.claimThrone{value: 1 ether}();

        attackerKingOfEther.attack{value: 2 ether}();

        vm.expectRevert("Failed to send ether");
        kingOfEther.claimThrone{value: 3 ether}();

        vm.stopPrank();
    }
}
