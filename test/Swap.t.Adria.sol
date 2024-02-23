// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

/*
    1. Interfaz del router (setup)
    2. Interfaz token ERC20 (setup)
    3. Direcciones del router, WETH y DAI (setup)
    4. Crear el fork (setup)
    5. Darle tokens a alice y aprobar el router (setup)
    6. Crear el path (test)
    7. Ejecutar swap y guardar resultado de las cantidades intercambiadas (test)
*/

interface IRouter {
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);
}

interface IERC20 {
    function approve(address spender, uint256 value) external returns (bool);
    function balanceOf(address user) external returns (uint256);
}

contract SwapTest is Test {
    // Router -> 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
    // WETH -> 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
    // DAI -> 0x6b175474e89094c44da98b954eedeac495271d0f

    IRouter public router;
    IERC20 public weth;
    IERC20 public dai;
    address public alice;

    uint256 mainnetFork; // identificador del fork de mainnet

    function setUp() public {
        string memory MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");
        mainnetFork = vm.createSelectFork(MAINNET_RPC_URL);

        alice = makeAddr("alice");

        router = IRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        weth = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);

        deal(address(weth), alice, 10 * 1e18); // damos WETH a alice

        vm.startPrank(alice);

        weth.approve(address(router), 10 * 1e18); // alice aprueba el router para que mueva sus WETH
    }

    function testSwap() public {
        // Creamos el path
        address[] memory path = new address[](2);

        path[0] = address(weth);
        path[1] = address(dai);

        // Ejecutamos el swap
        router.swapExactTokensForTokens(1 ether, 0, path, alice, block.timestamp);

        console.log("DAI obtenidos para alice:", dai.balanceOf(alice));
    }
}
