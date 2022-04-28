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

    /// @notice mint a NFT
    /// @param recipient destination address
    function mint(address recipient) public onlyOwner returns (uint256) {
        uint256 newItemId = ++currentTokenId;
        _safeMint(recipient, newItemId);
        return newItemId;
    }

    function _baseURI()
        internal
        view
        override
        onlyOwner
        returns (string memory)
    {
        return baseTokenURI;
    }

    /// @notice set a new baseTokenURI
    /// @param _baseTokenURI the new base token URI
    function setBaseURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    /// @notice retrieve all tokenIDs owned by an address
    /// @param _owner address
    /// @return array of tokenIDs owned by address
    function walletOfOwner(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256 tokenCount = balanceOf(_owner);

        uint256[] memory tokensId = new uint256[](tokenCount);
        for (uint256 i; i < tokenCount; i++) {
            tokensId[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokensId;
    }
}
