// // SPDX-License-Identifier: UNLICENSED
// pragma solidity 0.8.4;

// contract goodsExistence{
//     struct goodsDetails{
//         uint _ID;
//         uint noOfApprovals;
//         uint amount;
//         string name;
//         bool status;
//         address supplier;
//     }

//     address CEO;
//     uint minimumSigner;
//     uint ID;
//     address storeKeeper;


//      mapping(address => bool) private MappedSigner;
//      mapping(uint =>mapping(address => bool)) checkApproval;
//      mapping(address => uint) public IDOfGoodsSupplied;
//      mapping(uint=>goodsDetails) private RetrieveAvailableGoods;




//     goodsDetails[] public goodsToBeOrdered;
//      goodsDetails[] public ItemsInStore;


//     constructor(uint _minimumSigner, address _storeKeeper){
//         CEO =msg.sender;
//         require(CEO != _storeKeeper, "you are the ceo");
//         minimumSigner = _minimumSigner;
//         storeKeeper = _storeKeeper;
//     }
//     modifier _onlyCEO(){
//         require(msg.sender== CEO, "get the fuck you are not the ceo");
//         _;
//     }

//     modifier _onlySigner(){
//         require(MappedSigner[msg.sender] == true, "get the fuck you are not a signner");
//         _;
//     }

//     modifier _supplyCheckers(){
//          require(msg.sender==CEO || msg.sender == storeKeeper);
//          _;

//      }


//      function addgoods(
//         address _address,
//         string memory name,
//         uint amount,
//         ,
//         string memory _state_of_origin
//         ) public onlyAdmin returns(bool, uint) {
            
//             if(addressExist(_address)) {
//                 return (false, studentsToID[_address]);
//             }

//             ID = ID + 1;

//             StudentRec memory newStudent = StudentRec(ID, _fullname, _DOB, _gender, _state_of_origin);

//             studentsRecords.push(newStudent);

//             studentsToID[_address] = ID;

//             IDToRecord[ID] = newStudent;

//             return(true, ID);

//     }



//     // function sentOrder(uint id) external returns(bool, uint){
//     //     require(msg.sender == goodsToBeOrdered[id].supplier, "You are not the supplier");
//     //     require(goodsToBeOrdered[id].noOfApprovals >= minimumSigner, "Dear supplier be calm, minimum approval not met");

        
//     //    uint newID = ItemsInStore.length;
//     //       goodsDetails  memory supplies = goodsDetails(newID,
//     //      goodsToBeOrdered[id].noOfApprovals, goodsToBeOrdered[id].amount,
//     //      goodsToBeOrdered[id].name,goodsToBeOrdered[id].status, msg.sender);
//     //       ItemsInStore.push(supplies);
//     //       RetrieveAvailableGoods[newID] = supplies;
//     //       IDOfGoodsSupplied[msg.sender]= newID;

//     //         uint requestTobeRemoved;
//     //       for(uint i; i< goodsToBeOrdered.length; i++){
//     //           if(goodsToBeOrdered[i]._ID == id){
//     //               i = requestTobeRemoved;
//     //               break;
//     //           }
//     //           goodsToBeOrdered[requestTobeRemoved] = goodsToBeOrdered[goodsToBeOrdered.length -1];
//     //           goodsToBeOrdered.pop();

//     //       }

//     //       return (true, newID);    
//     // }
//     //  mapping(address => uint) public IDOfGoodsSupplied;
