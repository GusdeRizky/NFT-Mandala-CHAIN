// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {NFTSatu} from "../src/NFTSatu.sol";

contract NFTTest is Test {
    NFTSatu public nftSatu;
    address public owner = address(1);
    address public user2 = address(2);

    function setUp() public {
        vm.prank(owner);
        nftSatu = new NFTSatu();
    }

    function testMintNFT() public {
        vm.prank(owner);
        uint256 tokenId = nftSatu.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");

        assertEq(tokenId, 1);
        assertEq(nftSatu.ownerOf(1), owner);
    }

    function testRevertNonOwnerMint() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(user2);
        nftSatu.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");
    }

    function testRevertTransfer() public {
        vm.prank(owner);
        uint256 tokenId = nftSatu.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");

        vm.expectRevert(NFTSatu.CannotTransfer.selector);
        vm.prank(owner);
        nftSatu.transferFrom(owner, user2, tokenId);
    }

    function testRevertApprove() public {
        vm.prank(owner);
        uint256 tokenId = nftSatu.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i");

        vm.expectRevert(NFTSatu.CannotApprove.selector);
        vm.prank(owner);
        nftSatu.approve(user2, tokenId);
    }

    function testRevertApproveForAll() public {
        vm.prank(owner);
        nftSatu.mintNFT("https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5");

        vm.expectRevert(NFTSatu.CannotApprove.selector);
        vm.prank(owner);
        nftSatu.setApprovalForAll(user2, true);
    }
}
