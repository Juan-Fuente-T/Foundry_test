// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
//import "https://github.com/transmissions11/solmate/blob/main/src/tokens/ERC20.sol";
//import "https://github.com/transmissions11/solmate/blob/main/src/tokens/ERC20.sol";
/*
    - funcion de receive() para poder recibir el ether que nos envíe AAVE depues de hacer el withdraw()
    - crear nuestro token ERC20 (miniETH)
    - crear una función deposit()
        - validar datos
        - darle al usuario el token miniYearn
        - deposito en AAVE
    - crear una función withdraw()
    - saber el balance total de nuestro contrato: preguntar el balance de aTokens (aETH) que tiene el contrato MiniYearn 
    - crear una funcion para calcular el precio de un token miniYearn
*/

/*interface IPool{
    function supply (address asset, uint256 amount, address onBehalfOf, uint256 referralCode) external;
}*/

interface IWrappedTokenGetway{
    function depositETH(address pool, address onBehalfOf, uint16 referralCode) external payable;
    function withdrawETH(address pool, uint256 amount, address to) external;
}

interface IAToken{
    function balanceOf(address user) external returns (uint256);
    function scaledBalanceOf(address user) external returns(uint256);
    function approve(address _spender, uint256 value) external returns (bool success);

}
contract MiniYearn /*is ERC20*/{
    
    IWrappedTokenGetway gateway; //WETH Gateway 0xD322A49006FC828F9B5B37Ab215F99B4E5caB19C
    address pool; //0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2
    IAToken aETH; //0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8


    constructor (address _pool, address _gateway, address _aETH) ERC20("MiniYearn", "MYT", 18){
        pool = _pool;
        gateway = IWrappedTokenGetway(_gateway);
        aETH = IAToken(_aETH);
    }

    error NoPuedeSerCero();
    error MasDeLoQueTienes();

    
    ///address public constant POOL = 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;(parece que no hace falta)

    ///address public owner;(parece que no hace falta)
    //pool address 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2
    //function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode)


    ///CEI: Checks, Effects, Interactions

    function deposit() payable external{
        ///IPool (POOL).supply(0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC, 1, address(this), 0);(parece que no hace falta)
        ///Checks: comprobar que el msg.value sea mayor que cero
        if (msg.value == 0){
            revert NoPuedeSerCero();
            ///ejemplo error con require:
            ///require (msg.value > 0, "No puede ser cero");
        }

        ///Efects: minterar el ERC20
        _mint(msg.sender, msg.value);
        ///Interactions: hacer el deposito en AAVE
        gateway.depositETH{value: msg.value}(pool, address(this), 0);
    }

    function withdraw(uint256 amount) public{
        //habria que calcular el porcentaje de ganancia en el token del sobre el aumento de valor del token en AAve
        //Checks

        if (amount > balanceOf[msg.sender]){
            revert MasDeLoQueTienes();
        }
        //Effetcs
        _burn(msg.sender, amount);
        //El usuario tiene un porcentaje del total de miniyearns, por ejemplo 10%

        //Se resta dinero en AAVE menos dinero en Miniyearn, por ejemplo 11-10 = 1

        //De ese 1 el 10% debe ir extra al usuario

        aETH.approve(address(gateway), amount);//+10% de 1
        //Interacts

        gateway.withdrawETH(pool, amount, msg.sender);//+10% de 1


    }

    function getPrice() public returns(uint256){
        return aETH.scaledBalanceOf(address(this)) * 10 ** 18 / totalSupply;

    }

    function getUnderlying() public returns (uint256){
        return aETH.balanceOf(address(this));
    }

}

