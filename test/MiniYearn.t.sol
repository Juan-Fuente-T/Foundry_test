// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;

import {Test, console, console2} from "../lib/forge-std/src/Test.sol";
import {MiniYearn} from "../src/MiniYearn.sol";

contract MiniYearn is Test {
    MiniYearn miniYearn;

    address public pool;
    address public gateway;
    address public aEth;

    //addres 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

    function setUp() public {
        miniYearn = new MiniYearn();

        pool = makeAddr("pool");
        gateway = makeAddr("gateway");
        aEth = makeAddr("aEth");
        
    }


    function testAttack() public {
        
        //vm.deal(alice, 2 wei);
        //vm.deal(address(fallbackTest), 1000 ether);

        vm.startPrank(origin pool, gateway, aEth);
        miniYearn.deposit{value: 1 eth}();
        
        //bool sent = fallbackTest.send{value: 0.000005 ether}(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);

        //payable(address(fallbackTest)).transfer(1 wei); da problemas de gas, usar call
        payable(address(fallbackTest)).call{value: 1 wei}("");


        
        /*function transfer (address payable _to)  public payable  {
      // This function is no longer recommended for sending Ether.
      _to.transfer(msg.value);*/

        

        vm.stopPrank();

        console.log("El owner es", 4);
    }
