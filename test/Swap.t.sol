// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "../lib/forge-std/src/Test.sol";

/**
 * PASOS PARA TESTEAR:
 * 1. Importar y heredar del contrato Test
 * 2. Importar y declarar la/s variable/s mi/s contrato/s que quiero testear
 * 3. Crear una función de setUp (OBLIGATORIO)
 *     3.1 Deployar mis contratos
 *     3.2 (OPCIONAL) Configurar mis contratos (solo si lo necesito)
 * 4. Crear mis funciones de test (tantas como yo quiera)
 */
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
    function balanceOf(address account) external returns (uint256);
}

contract SwapTest is Test {
    IRouter public router;
    IERC20 public dai;
    IERC20 public weth;

    address public alice;
    uint256 mainnetFork;

    // Router -> 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
    // WETH -> 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2
    // DAI -> 0x6B175474E89094C44Da98b954EedeAC495271d0F

    function setUp() public {
        //forge test --fork-url MAINNET_RPC_URL;
        string memory MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");
        mainnetFork = vm.createSelectFork(MAINNET_RPC_URL);

        alice = makeAddr("alice");
        console.log("Alice", alice);

        router = IRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        weth = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);

        //deal(direccionToken, direccionAQuien, cantidad)
        deal(address(weth), alice, 10 * 10 ** 18);
        assertEq(weth.balanceOf(alice), 10 * 1e18);
        console.log("Balance Alice", weth.balanceOf(alice));

        vm.startPrank(alice);
        weth.approve(address(router), 10 * 1e18);
        //weth.approve(address(router), type(uint256).max);
    }

    function testSwap() public {
        address[] memory path = new address[](2);
        path[0] = address(weth);
        path[1] = address(dai);
        //path[1] = 0x6b175474e89094c44da98b954eedeac495271d0f;
        //router.swapExactTokensForTokens(amountIn, amountOutMin, path, to, deadline);
        uint256[] memory amounts = router.swapExactTokensForTokens(1 ether, 0, path, alice, block.timestamp);
        //recuerda que un ether solo significa 1e18 (1*10**18)
        console.log("DAI obtenidos por alice", dai.balanceOf(alice));
        console.log("Amounts de weth intercambiado", amounts[0]);
        console.log("Amounts de dai intercambiado", amounts[1]);
    }
}
