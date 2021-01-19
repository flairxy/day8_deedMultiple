pragma solidity >=0.4.21 <0.7.0;

contract Deed{
  event txnSuccess(string _message);
  address public lawyer;
  address payable public beneficiary;
  uint public earliest;

  constructor(address _lawyer, address payable _beneficiary, uint fromNow) payable public{
    lawyer = _lawyer;
    beneficiary = _beneficiary;
    earliest = now + fromNow;
  }

  function withdraw() public {
    require(msg.sender == lawyer, 'only the lawyer can perform this transaction');
    require(now >= earliest, 'too early');
    beneficiary.transfer(address(this).balance);
    emit txnSuccess('Withdrawal successful');
  }
}