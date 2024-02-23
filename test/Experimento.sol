// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importar la interfaz del estándar ERC-20
import "../lib/forge-std/src/interfaces/IERC20.sol";
import {Test, console2, console} from "../lib/forge-std/src/Test.sol";


/*contract MiContratoPrueba is IERC20{
    IERC20 public miToken; // Dirección del contrato del token MiToken

    string immutable name;
    string immutable symbol;
    uint256 decimals;

    constructor(address _miTokenAddress) {
        miToken = IERC20(_miTokenAddress);
    }

    constructor() {
        name = MiToken;
        symbol = MTK;
        decimals = 18;

        //INITIAL_CHAIN_ID = block.chainid;
        //INITIAL_DOMAIN_SEPARATOR = computeDomainSeparator();
    }

    // Función para depositar tokens en el contrato
    function deposit(uint256 amount) public {
        require(amount > 0, "El monto debe ser mayor que cero");
        require(miToken.transferFrom(msg.sender, address(this), amount), "Transferencia fallida");
    
    }

    // Función para retirar tokens y quemarlos
    function withdraw(uint256 amount) external {
        require(amount > 0, "El monto debe ser mayor que cero");
        require(miToken.transferFrom(msg.sender, address(this), amount), "Transferencia fallida");
        _burnTokens(amount);
    }

    // Función privada para quemar tokens
    function _burnTokens(uint256 amount) private {
        require(miToken.transfer(address(0x0), amount), "Quema de tokens fallida");
    }

    // Función para consultar el saldo del contrato
    function contractBalance() external view returns (uint256) {
        return miToken.balanceOf(address(this));
    }
}*/