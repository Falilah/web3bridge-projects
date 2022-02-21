// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;
contract Escrow {
  address public seller;
  address public buyer;
  address public arbitrator;

  uint256 public purchasePrice;
  uint256 public purchaseConfirmationCount;
  uint256 public refundConfirmationCount;

  mapping(address => bool) public hasConfirmedPurchase;
  mapping(address => bool) public hasConfirmedRefund;

  constructor(
    address seller_,
    address buyer_,
    address arbitrator_
  ) {
    seller = seller_;
    buyer = buyer_;
    arbitrator = arbitrator_;
  }

  modifier isRegisteredParticipant {
    require(
      msg.sender == seller ||
        msg.sender == buyer ||
        msg.sender == arbitrator,
      "Only registered participants can call this"
    );

    _;
  }

  function depositIntoEscrow() external payable {
    require(purchasePrice == 0, "Already deposited");
    require(
      msg.sender == buyer,
      "Only buyer should deposit into escrow"
    );
    purchasePrice = msg.value;
  }

  function confirmPurchase() external isRegisteredParticipant {
    require(
      !hasConfirmedPurchase[msg.sender],
      "Already confirmed purchase"
    );

    hasConfirmedPurchase[msg.sender] = true;
    purchaseConfirmationCount = purchaseConfirmationCount + 1;

    if (purchaseConfirmationCount >= 2) {
      _sendFundsTo(seller);
    }
  }

  function confirmRefund() external isRegisteredParticipant {
    require(
      !hasConfirmedRefund[msg.sender],
      "Already confirmed refund"
    );

    hasConfirmedRefund[msg.sender] = true;
    refundConfirmationCount = refundConfirmationCount + 1;

    if (refundConfirmationCount >= 2) {
      _sendFundsTo(buyer);
    }
  }

  function _sendFundsTo(address recipient) private {
    if(!hasConfirmedPurchase[arbitrator] && recipient == buyer){
      uint buyerRefund = (70 * purchasePrice)/ 100;
      uint sellerRefund = (30 * purchasePrice)/ 100;
    (bool success, ) = recipient.call{value: buyerRefund}("");
    (bool succeed, ) = seller.call{value: sellerRefund}("");

    require(success, "Sending funds transaction failed");
    }else{
      (bool success, ) = recipient.call{value: purchasePrice}("");
    require(success, "Sending funds transaction failed");
    }
  }
}