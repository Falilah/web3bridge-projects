// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract TokenB {

    constructor(string memory _name, string memory _symbol) ERC20("Gold2", "GT2"){
        _mint(msg.sender, 1e10 * 10 ** 18);
    }
    
}