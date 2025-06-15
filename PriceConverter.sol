// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

    function    getPriceFromInterface() internal view returns ( uint256 ){

        int256                 price;
        AggregatorV3Interface  contractLink = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        (
            ,
            price,
            ,
            ,
        ) = contractLink.latestRoundData();
        require( price >= 0, "ETH price is less than 0" );
        return ( uint256( price * 1e10 ) );
    }

    function    valueConvert( uint256 ethAmount ) public view returns( uint256 ){
        
        uint256 price = getPriceFromInterface();
        uint256 ethAmountUSD = ( price * ethAmount ) / 1e18;    

        return ( ethAmountUSD );
    }

    function getBalanceUSD() internal view returns ( uint256 ){

        uint256 price = getPriceFromInterface();

        return ( ( address( this ).balance * price));
    }    
}