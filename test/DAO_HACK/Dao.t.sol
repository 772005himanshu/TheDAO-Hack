// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../../src/DAO_HACK/DAO.sol";
import "../../src/DAO_HACK/attack_DAO.sol";


contract DaoHackTest is Test {
    TheDAO public dao;
    uint256 depositPerUser = 100 ether;
    
    
    address internal ishank;
    address internal vikash;
    address internal armaan;
    address internal hacker;

    function setUp() public {
        dao = new TheDAO();
        
        // vm.label is used for
        // Sets a label label for addr in test traces.
        // If an address is labelled, the label will show up in test traces instead of the address.

        vm.label(ishank,"ishank");
        vm.label(vikash,"vikash");
        vm.label(armaan,"armaan");
        vm.label(hacker,"hacker");


        vm.deal(ishank,101 ether);
        vm.deal(vikash,101 ether);
        vm.deal(armaan,101 ether);
        vm.deal(hacker,101 ether);

        dao.invest{value : depositPerUser}(ishank);
        dao.invest{value: depositPerUser}(vikash);
        dao.invest{value : depositPerUser}(armaan);

    }


    function testExploit() public  {
        uint256 daoBalance = address(dao).balance / 1 ether;
        // uint256 hackerBalance = address(hacker).balance / 1 ether ;

        console.log("Dao balance before exploit: %s",daoBalance);
        // console.log("hacker balance before exploit: %s",hackerBalance);

        AttackDAO daoAttacker = new AttackDAO(payable(address(dao)));

        daoAttacker.attack{value : 100 ether}();
        uint256 attackerBalanceContract = address(daoAttacker).balance / 1 ether;

        // daoAttacker.withdrawETHToOwner();


        // uint256 hackerBalanceAfter = address(hacker).balance / 1 ether ;
        uint256 daoBalanceAfter = address(dao).balance/ 1 ether;

        console.log("DAO balance after exploit: %s",daoBalanceAfter);
        console.log("attacker contract balance after exploit: %s",attackerBalanceContract);

        // console.log("Hacker balance after exploit: %s",hackerBalanceAfter);
    }


}