// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "lib/forge-std/src/Test.sol";
import {Counter} from "../src/Counter.sol";


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
 
    event Incremented(uint256 number);
 
    Counter public counter; /// variable de tipo Counter (con mayúscula, mi contrato Counter)
 
    address public alice; 
    address public bob; 
    address public charlie; 
 
    function setUp() public { /// Siempre se ejecutará la primera
        alice = makeAddr("alice");
        bob = makeAddr("bob");
        charlie = makeAddr("charlie");
 
        vm.prank(alice);
        counter = new Counter(); /// deployar el contrato Counter
 
    }
 
    function testIncrementPositives() public {
        vm.startPrank(alice);
 
        vm.expectEmit();
        emit Incremented(1); /// evento que espero que se emita
 
        counter.increment(); /// ejecutamos la funcion increment() del contrato   
 
        assertEq(counter.number(), 1); /// compruebo que la función ha dado el resultado esperado
 
        counter.increment(); /// el numero pasa de 1 a 2
 
        vm.stopPrank();
    }
 
    function testIncrementNegatives() public {
        /// Comprobar que el `onlyOwner` falla si la transaccion la ejecuta alguien que no es el owner
        vm.expectRevert(abi.encodeWithSignature("NotOwner()"));
        counter.increment();
    }
 
}