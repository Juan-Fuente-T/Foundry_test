// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "lib/forge-std/src/Test.sol";
import {Delegation} from "../Ethernaut/Delegation.sol";

/**
 * PASOS PARA TESTEAR:
 * 1. Importar y heredar del contrato Test
 * 2. Importar y declarar la/s variable/s mi/s contrato/s que quiero testear
 * 3. Crear una función de setUp (OBLIGATORIO)
 *     3.1 Deployar mis contratos
 *     3.2 (OPCIONAL) Configurar mis contratos (solo si lo necesito)
 * 4. Crear mis funciones de test (tantas como yo quiera)
 */

contract DelegationTest is Test {
    Delegation public delegation;

    function setUp() public {
    }
}