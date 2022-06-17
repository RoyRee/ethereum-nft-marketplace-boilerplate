
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract NFTMarketPlace is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor(string memory contractName, string memory symbol) ERC721(contractName,symbol) {}


    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}

contract Factory  {

    address[] private _contractAddresses;

    function deployERC721(string calldata _name, string calldata _symbol) public {
        NFTMarketPlace tempContract = new NFTMarketPlace(_name, _symbol);
        tempContract.transferOwnership(msg.sender);
        _contractAddresses.push(address(tempContract));
    }

    function fetchContractAddress() public view returns(address[] memory){
        return _contractAddresses;
    }

}


