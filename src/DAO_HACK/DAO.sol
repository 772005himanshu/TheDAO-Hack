// SPDX-License-Identifier: MIT

// simplified DAO Contract

pragma solidity ^0.8.13;

contract TheDAO {
  event Investment(address indexed investor, uint256 indexed amount);
  event Withdrawal();

  mapping(address => uint256) private balances;

  function invest(address _to) public payable {
    balances[_to] += msg.value;
    emit Investment(_to, msg.value);
  }

  function balanceOf(address _who) public view returns (uint256 balance) {
    return balances[_who];
  }

  function withdraw() public {

    require(balances[msg.sender] > 0 ether);

    uint256 balance = balances[msg.sender];
    
    (bool result, bytes memory data) = msg.sender.call{value: balance}("");
    
    balances[msg.sender] = 0;

    emit Withdrawal();

  }

  fallback() external payable {}
}