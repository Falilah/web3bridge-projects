// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract fundraiserOrg{
    struct FundOrgReturnMain{
        uint [] fundraiserID;
        uint goalamount;
        uint minDonation;
        uint donatorCount;
        uint256 expirationDate;
        bool isCompleted;
        string title;
        string desc;
        string hostname;
        address hostaddress;
        address recipientaddress;
        mapping (address => uint) donators;
        mapping (uint => address) donatorsAdddress;


    }

    struct FundOrgReturn {
        uint [] fundraiserID;
        uint goalamount;
        uint minDonation;
        uint donatorCount;
        uint256 expirationDate;
        bool isCompleted;
        string title;
        string desc;
        string hostname;
        address hostaddress;
        address recipientaddress;
        uint donation;
        address donatorsAddress;

    }

    mapping(string=>FundOrgReturnMain) FundingOrg2;

    function addDonation(uint [] memory ID, uint _goalamount, uint _minimumDonation,uint256 _expirationDate, string calldata _title,address _hostaddress, address _recipient, string calldata hostname, uint _id, address add) external{
    FundOrgReturnMain storage F=FundingOrg2[hostname];
    F.fundraiserID = ID;
    F.goalamount=_goalamount;
    F.minDonation=_minimumDonation;
    F.expirationDate=_expirationDate;
    F.title=_title;
    F.hostaddress=_hostaddress;
    F.recipientaddress=_recipient;
    F.donators[add] = _id;
    F.donatorsAdddress[_id] =  msg.sender;
    }

    function seefundraiser(string[] memory _fr, address _addr,uint _id) external view returns(FundOrgReturn[] memory Funds){
    Funds = new FundOrgReturn[](_fr.length);
    for(uint i=0;i<_fr.length;i++){
        Funds[i].fundraiserID = FundingOrg2[_fr[i]].fundraiserID;
        Funds[i].goalamount = FundingOrg2[_fr[i]].goalamount;
        Funds[i].minDonation = FundingOrg2[_fr[i]].minDonation;
        Funds[i].expirationDate = FundingOrg2[_fr[i]].expirationDate;
        Funds[i].title = FundingOrg2[_fr[i]].title;
        Funds[i].hostaddress = FundingOrg2[_fr[i]].hostaddress;
        Funds[i].recipientaddress = FundingOrg2[_fr[i]].recipientaddress;
        Funds[i].donation = FundingOrg2[_fr[i]].donators[_addr];
        Funds[i].donatorsAddress = FundingOrg2[_fr[i]].donatorsAdddress[_id];




    }
    }

    function getDonation(address _addr, string memory _don) external view returns(uint){
        return FundingOrg2[_don].donators[_addr];

    }
    function getAddress(uint _id, string memory _don) external view returns(address){
        return FundingOrg2[_don].donatorsAdddress[_id];

    }






}