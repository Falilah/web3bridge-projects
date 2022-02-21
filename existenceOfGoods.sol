// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

contract goodsExistence{
    struct goodsDetails{
        uint amount;
        uint noOfApprovals;
        string name;
        bool status;
        address supplier;
    }

    address CEO;
    uint minimumSigner;
    uint ID;
    address storeKeeper;


     mapping(address => bool)private MappedSigner;
     mapping(uint =>mapping(address => bool)) checkApproval;
     mapping(uint=>goodsDetails) private GoodsOnRequest;


    constructor(uint _minimumSigner, address _storeKeeper){
        CEO =msg.sender;
        require(CEO != _storeKeeper, "you are the ceo");
        minimumSigner = _minimumSigner;
        storeKeeper = _storeKeeper;
    }


    modifier _onlyCEO(){
        require(msg.sender== CEO, " you are not the ceo");
        _;
    }

    modifier _onlySigner(){
        require(MappedSigner[msg.sender] == true, "you are not a signner");
        _;
    }


    function setSigner(address[] memory Signers) public _onlyCEO {
        for(uint i; i < Signers.length; i++){
            address signer = Signers[i];
        require(signer != storeKeeper, "A storeKeeper can't be the head of the department");
        require(MappedSigner[signer] == false, "one Addres can't head more than 1 department");
        require(signer != CEO, "The ceo can't be part of the signer");

            MappedSigner[signer] = true;
       }
    }
    function checkSigners(address _addr) public view returns(bool){
        return MappedSigner[_addr];
    }
    

    function changeStoreKeeper(address _store) public _onlyCEO {
        require(storeKeeper != _store, "this is the current stoeKeeper");
        require(msg.sender != _store,"you can't be the storeKeeper");
        require(MappedSigner[_store] == false, "No head of department can be a store keeper");
        storeKeeper = _store;       
    }
    function RequestOrder(string memory _name, 
    address to,
     uint _amount)
      public{
        require(msg.sender == storeKeeper, "You can't make request. Not the storeKeeper");
        goodsDetails storage request = GoodsOnRequest[ID];
        request.amount = _amount;
        request.name =_name;
        request.noOfApprovals = 0;
        request.supplier = to;
        ID = ID + 1;

    }

    function ApprovedTransaction(uint id) public _onlySigner{
        require(id <= ID, "the reguired Id has no information avaialable");
        require(GoodsOnRequest[id].noOfApprovals < minimumSigner, "You can't approved more than once!");
        ++GoodsOnRequest[id].noOfApprovals;
    }

    function TotalNoOfApproval(uint id) external view returns(uint){
        return GoodsOnRequest[id].noOfApprovals;       
    }

    function makeOrder(uint _id)public _onlySigner returns(bool){
        require(GoodsOnRequest[_id].status == false, "order has been made");
        require(GoodsOnRequest[_id].noOfApprovals >= minimumSigner, "get minimum required to make Order");
        GoodsOnRequest[_id].status = true;
        return true;
    }

    function checkAvilableGoods(uint identifier) external view returns(goodsDetails[] memory checkStatus){
        checkStatus = new goodsDetails[](identifier);  
        for(uint i = 0; i < identifier; i++) {
            if(GoodsOnRequest[i].status == false){
                continue;
            }
            checkStatus[i] = GoodsOnRequest[i];


        }
        checkStatus;
    }

    receive() external payable{}
}

    // ["0x583031D1113aD414F02576BD6afaBfb302140225", "0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB", "0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C", "0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c", "0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC", "0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C"]
