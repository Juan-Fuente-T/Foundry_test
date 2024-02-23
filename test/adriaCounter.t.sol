// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
//import {Test, console2, console} from "C:/Users/Juan/Desktop/Programación/Foundry/lib/forge-std/Test.sol";
//import {Counter} from "C:/Users/Juan/Desktop/Programación/Foundry/src/Counter.sol";

/**
PASOS PARA TESTEAR:
1. Importar y heredar del contrato Test
2. Importar y declarar la/s variable/s mi/s contrato/s que quiero testear
3. Crear una función de setUp (OBLIGATORIO)
    3.1 Deployar mis contratos
    3.2 (OPCIONAL) Configurar mis contratos (solo si lo necesito)
4. Crear mis funciones de test (tantas como yo quiera)
 */

contract CounterTest is Test {

    Counter public counter; /// variable de tipo Counter (con mayúscula, mi contrato Counter)

    function setUp() public { /// Siempre se ejecutará la primera
        counter = new Counter(); /// deployar el contrato Counter
        counter.setNumber(10); /// darle un valor de 10 al number del contrato Counter
    }

    function testIncrement() public {
        counter.increment(); /// ejecutamos la funcion increment() del contrato   
        assertEq(counter.number(), 11); /// compruebo que la función ha dado el resultado esperado
        console.log("El numero es:", counter.number());
    }

    function testNumber() public {
        counter.setNumber(10);
    }

}