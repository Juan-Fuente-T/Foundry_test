// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import {Test, console, console2} from "../lib/forge-std/src/Test.sol";
import {Force} from "../Ethernaut/Force.sol";

contract TestForce is Test {
    TestForce testForce;

    address public force;
    

    //addres 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

    function setUp() public {
        //n
         testForce = new TestForce();

        //force = makeAddr("force");
        //bob = makeAddr("bob");
    }

    //fallbackTest.owner = bob;

    function testAttack() public {
        address payable addr = payable(address(testForce));
        selfdestruct(addr);
    }
}