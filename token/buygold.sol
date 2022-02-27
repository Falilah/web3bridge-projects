// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract buyGold{
    IERC20 goldToken;

    uint startDate = block.timestamp;
    uint endDate = startDate + 10 days;


    uint minimumBuy;
    uint maximumBuy;

    uint tokenRate = 200;

    event tokensale(address from, uint to, uint amount);

    constructor(address goldToken, uint _minimunBuy, uint _maximumBuy){
        goldToken = IERC20(goldToken);
        minimumBuy = _minimumBuy;
        maximumBuy = _maximumBuy;
    }

    function buyGoldToken() external {
        require(startDate >= block.timestamp, "sales of token has not began");
        require(endDate <= block.timestamp, "sales of token has ended");
        require(minimumBuy >= msg.value, "you can't buy less than 500 token");
        require(maximum <= msg.value, "you can't buy more than 10,000 token");
        uint amount = msg.value * tokenRate;
        uint tokenBalance = checkBalance();
        require(tokenBalance >= amount, "insufficient token for sale");
        
        goldToken.transfer(msg.sender, amount);

        address owner = msg.sender;
        emit tokensale(goldToken.address(this), owner, amount);


    }
    function checkBalance()private view returns(uint){
        return goldToken.balanceOf(address(this);
}