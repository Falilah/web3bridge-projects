// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

contract goodsExistence{

    struct Demand{
        string __name;
        uint qty;
        mapping(uint => address) customersAddress;
    }
    struct DemandWithoutMapping{
        string __name;
        uint qty;
    } 
    struct goodsDetails{
        string name;
        uint amount;
        string[] sizes;
        mapping(uint => string) supplier;
        Demand customer; 
    }

      
    struct structWithoutMApping{
        string name;
        uint amount;
        string[] sizes;
        DemandWithoutMapping cust;

    }

    uint Id = 1;

    
     mapping(string=>goodsDetails) private Goods;

     function addGoods(string memory _name, 
    
     uint _amount,
      string[] memory _size,
      string memory position,
      uint _qty, address addr,string memory _customer)
    
      public{
        goodsDetails storage request = Goods[position];
        request.name =_name;
        request.amount = _amount * _qty;
        request.sizes= _size;
        request.supplier[(Id + 100)]= position;
        request.customer.__name = _customer;
        request.customer.qty = _qty ;
        request.customer.customersAddress[(Id+500)] = addr;
        Id++;

    }

    function getCustomersAddress(string memory _position, uint _id) external view returns(address){
        return Goods[_position].customer.customersAddress[_id];


    }
    function checkProduct(string[] memory _position) external view returns(structWithoutMApping[] memory SWM){
        SWM = new  structWithoutMApping[](_position.length);
        for(uint i; i < _position.length; i++){
        SWM[i].name = Goods[_position[i]].name;
        SWM[i].amount = Goods[_position[i]].amount;
        SWM[i].sizes = Goods[_position[i]].sizes;
        SWM[i].cust.__name = Goods[_position[i]].customer.__name;
        SWM[i].cust.qty = Goods[_position[i]].customer.qty; 
    }
    }
    
}    