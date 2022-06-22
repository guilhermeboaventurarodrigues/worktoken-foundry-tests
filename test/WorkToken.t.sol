// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WorkToken.sol";

contract WorkTokenTest is Test{

    WorkToken token;
    address alice = vm.addr(0x1);
    address bob = vm.addr(0x2);

    function setUp() public{
        token = new WorkToken(1000);
    }

    //TESTS OK
    function testTotalSupply() public {
        assertEq(token.totalSupply(), 1000);
    }

    function testBalanceOf() public{
        assertEq(token.balanceOf(address(this)), 1000);
    }

    function testTransfer() public{
        token.transfer(alice, 500);
        assertEq(token.balanceOf(alice), 500);
    }
    
    function testApprove() public{
        assertTrue(token.approve(alice, 400));
    }

    function testAllowence() public{
        token.approve(alice, 400);
        assertEq(token.allowance(address(this), alice), 400);
    }

    function testTransferFrom() public{
        token.approve(alice, 400);
        vm.prank(alice);
        token.transferFrom(address(this), bob, 400);
        assertEq(token.balanceOf(bob), 400);
    }


    //TESTS FAIL
    function testFailTransferFromBalanceInsufficient() public{
        token.approve(alice, 400);
        vm.prank(alice);
        token.transferFrom(address(this), bob, 500);
    }

    function testFailTransferBalanceInsufficient() public{
        token.transfer(alice, 1001);
    }

    function testFailApproveBalanceInsufficient() public{
        token.approve(alice, 1001);
    }
}