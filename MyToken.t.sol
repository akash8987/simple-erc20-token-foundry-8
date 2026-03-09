// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "./MyToken.sol";

contract MyTokenTest is Test {
    MyToken public token;
    address public owner = address(1);
    address public user = address(2);
    uint256 public initialSupply = 1000;

    function setUp() public {
        vm.prank(owner);
        token = new MyToken(initialSupply);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), initialSupply * 10 ** token.decimals());
        assertEq(token.balanceOf(owner), initialSupply * 10 ** token.decimals());
    }

    function testMinting() public {
        vm.prank(owner);
        token.mint(user, 500);
        assertEq(token.balanceOf(user), 500);
    }

    function testFailNonOwnerMinting() public {
        vm.prank(user);
        token.mint(user, 500);
    }
}
