// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.10;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFTCollection is ERC721Enumerable, Ownable {
    uint256 public currentTokenId;

    string private baseTokenURI;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseTokenURI
    ) ERC721(_name, _symbol) Ownable() {
        baseTokenURI = _baseTokenURI;
    }

    function mintTo(address recipient) public onlyOwner returns (uint256) {
        uint256 newItemId = ++currentTokenId;
        _safeMint(recipient, newItemId);
        return newItemId;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function setBaseURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }
}
