// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import {Test, console, console2} from "../lib/forge-std/src/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token token;
    uint256 TOTAL_SUPPLY = 20;

    function setUp() public {
        token = new Token(TOTAL_SUPPLY);
    }

    function TestToken() public {
        //function transfer(address(token), {value:25 ether}) public;
        token.transfer(address(0), 25);
        token.balanceOf(address(this));
    }
}
