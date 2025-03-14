// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract NFTSatu is ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;
    error CannotTransfer();
    error CannotApprove();
    error CannotApproveForAll();
    
    event Minted(address indexed owner, uint256 indexed tokenId, string tokenURI);
    
    constructor() ERC721("Ida Bagus Rizky Brahmantya", "GR") {}
    
    function mintNFT(string memory base64Image) external onlyOwner returns (uint256) {
        uint256 tokenId = _tokenIdCounter + 1;
        _tokenIdCounter = tokenId;
        
        string memory metadata = _generateMetadata(base64Image);
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, metadata);
        
        emit Minted(msg.sender, tokenId, metadata);
        return tokenId;
    }
    
    function _generateMetadata(string memory imageUrl) internal pure returns (string memory) {
        string memory name = "Mandala Academy NFT";
        string memory description = "A certificate NFT that student already completed the course";
        
        bytes memory metadata = abi.encodePacked(
            "{",
            '"name": "',
            name,
            '",',
            '"description": "',
            description,
            '",',
            '"image_url": "',
            imageUrl,
            '"',
            "}"
        );
        
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(metadata)
                )
            );
    }
    
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override {
        if (from != address(0)) {
            revert CannotTransfer();
        }
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
    
    function approve(address /* to */, uint256 /* tokenId */) public pure override (ERC721, IERC721) {
        revert CannotApprove();
    }
    
    function setApprovalForAll(
        address /* operator */,
        bool /* approved */
    ) public pure override(ERC721, IERC721) {
        revert CannotApproveForAll();
    }
    
    function transferFrom(address /* from */, address /* to */, uint256 /* tokenId */) public pure override (ERC721, IERC721) {
        revert CannotTransfer();
    }
    
    function safeTransferFrom(address /* from */, address /* to */, uint256 /* tokenId */) public pure override(ERC721, IERC721) {
        revert CannotTransfer();
    }
    
    function safeTransferFrom(address /* from */, address /* to */, uint256 /* tokenId */, bytes memory /* data */) public pure override(ERC721, IERC721) {
        revert CannotTransfer();
    }
}
