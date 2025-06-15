// Get finds from users
// Withdraw funds
// Set a minimum funding in USD

// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{

    using PriceConverter for uint256;
    

    address private                                    admin;
    uint256 public                                     minimumUSD = 5e18;
    address[] public                                   funders;
    mapping( address funders => uint256 value)  public addressToAmount;

    function fund() public payable  {
        
        require( msg.value.valueConvert() >= minimumUSD, "Missing ETH" );
        funders.push( msg.sender );
        addressToAmount[ msg.sender ] += msg.value;
    }

    function withdraw() public {

        for (uint256 i = 0 ; i < funders.length ; i++)
            addressToAmount[ funders[i] ] = 0;
    }

}