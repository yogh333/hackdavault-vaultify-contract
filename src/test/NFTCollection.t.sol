// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import {NFTCollection} from "../NFTCollection.sol";

contract NFTCollectionTest is Test {
    NFTCollection collection;

    function setUp() public {
        collection = new NFTCollection("TestNFT", "TNFT", "http://db.com/");
    }

    function testMintAsOwner() public {
        assertEq(collection.balanceOf(msg.sender), 0);
        collection.mint(msg.sender);
        assertEq(collection.balanceOf(msg.sender), 1);
    }

    function testTransferOwnership() public {
        address owner = address(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84);
        address new_owner = address(0xC083c81F2F15Fd14aCCa5BD699f18E324c05e4Fb);
        assertEq(collection.owner(), owner);
        collection.transferOwnership(new_owner);
        assertEq(collection.owner(), new_owner);
    }

    function testGetTokenURI() public {
        collection.mint(msg.sender);
        assertEq(collection.tokenURI(1), "http://db.com/1");
    }

    function testSetBaseURI() public {
        collection.setBaseURI("http://ipfs.com/");
        collection.mint(msg.sender);
        console.log(collection.tokenURI(1));
        assertEq(collection.tokenURI(1), "http://ipfs.com/1");
    }
}
