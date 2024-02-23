// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "lib/forge-std/src/Test.sol";
import {Counter} from "../src/CounterEjemplo.sol";


/**
PASOS PARA TESTEAR:
1. Importar y heredar del contrato Test
2. Importar y declarar la/s variable/s mi/s contrato/s que quiero testear
3. Crear una función de setUp (OBLIGATORIO)
    3.1 Deployar mis contratos
    3.2 (OPCIONAL) Configurar mis contratos (solo si lo necesito)
4. Crear mis funciones de test (tantas como yo quiera)
 */

contract CounterTest is Test{

    Counter public counter;

    function setUp() public{
        counter = new Counter();
        counter.setNumber(100);

    }

    function testSetNumber() public{
        counter.setNumber(counter.number());
        assertEq(counter.number(), 100);
        console.log("El number es:", counter.number());
    }

}