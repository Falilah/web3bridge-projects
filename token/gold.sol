// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract wura is IERC20Metadata{
    string private name_;
    string private symbol_;
    uint8 private decimal_;
    uint private totalSupply_;

    address owner;

    mapping(address => uint) accountBalance;
    mapping(address => mapping(address=> bool)) private allowances;

    event transactionsMade(address from, address to, uint amount);

    constructor(string memory _name, string memory _symbol, uint8 _decimal, uint _totalSupply){
        name_ = _name;
        symbol_ = _symbol;
        decimal_ = _decimal;
        totalSupply_ = _totalSupply * 10 ** decimal_;
        owner = msg.sender;
        accountBalance[owner] = totalSupply_;

        emit transactionsMade(address(0), msg.sender, totalSupply_);

        
    }

    function name() external view override returns (string memory){
        return name_;
    }

    function symbol() external view override returns (string memory){
        return symbol_;
    }

        function decimals() external view override returns (uint8){
        return decimal_;
    }
    
    function totalSupply() external view override returns (uint256){
        return totalSupply_;
    }
        function balanceOf(address account) external view override returns (uint256){
        return accountBalance[owner];
    }

     function transfer(address to, uint256 _amount) external override returns (bool){
        //  require(msg.sender == owner);
         require(accountBalance[owner] <= _amount);
         require(to != address(0), "can't burn to adress 0");
         accountBalance[owner] -= _amount;
         accountBalance[to] += _amount;

        emit transactionsMade(msg.sender, to, _amount);

     }
     
    function allowance(address _owner, address spender) external view override returns (uint256){
        return allowances[_owner][spender];

    }

    function approve(address spender, uint256 amount) external override returns (bool){
        _approve(msg.sender, spender, amount);
        return true;

    }
    function _approve(address from, address to, uint amount){
        require(from != address(0), "Address(0) can't approve allowance");
        require(to != address(0), "can't transfer to address(0)");
        allowances[from][to] = amount;
    emit transactionsMade (from, to, amount);
        
    }

    transferFrom(address from, address to, uint amount) external override returns(bool){
        uint ApprovedAmount = allowance(from, msg.sender);
        require(ApprovedAmount <= amount), "you can;t request for more than approved");
        allowances[from][msg.sender] -= amount;

    emit transactionsMade (from, to, amount);

    return true;

    }




}