// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "../lib/forge-std/src/Test.sol";

interface IERC20 {
    function balanceOf(address account) external returns (uint256);
}

interface IRouter {
    function swapExactETHForTokens(
        uint256 amountOutMin, 
        address[] calldata path, 
        address to, 
        uint256 deadline
        ) external payable returns (uint256[] memory amounts);
}

contract Swap2Test is Test {
    // Router -> 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
    // WETH -> 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2

    IRouter public router;
    IERC20 public dai;
    IERC20 public weth;

    address public alice;

    uint256 mainnetFork;

    function setUp() public {
        router = IRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        //router = IRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        //weth = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
        //dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F);
        weth = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);

        alice = makeAddr("alice");

        string memory MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");
        mainnetFork = vm.createSelectFork(MAINNET_RPC_URL);

        //deal(address(weth),alice, 10*1e18); No es necesario darle weth, solo hay que iniciar weth para poder enviar el ether como si fuese weth, pero con que su balance sea de ether es suficiente para que funcione el test, de hecho es como tiene que funcionar, de eth nativo a token dai.
        vm.startPrank(alice);
        vm.deal(alice, 1 *1e18);
        assertEq(alice.balance, 1 ether);
        console.log("Balance Alice Ether", alice.balance);
    }

    function testSwap2() public payable {
    address[] memory path = new address[] (2);
    path[0] = address(weth);
    path[1] = address(dai);
    uint256[] memory amounts = router.swapExactETHForTokens{value: 1 * 10**18}(1620*1e18, path, alice, block.timestamp);
    //poner el precio de esta manera no es adecuado, puede generar denegacion de servicios DoS, mejor meterlo por parametro o consultar oraculo y quitar un %
    console.log("Balance de Alice en Dai", dai.balanceOf(alice));
    console.log("");
    console.log("Amounts de weth enviados", amounts[0]);
    console.log("Amounts de dai recibidos", amounts[1]);
 
 }
}
