// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing OpenZeppelin's ERC721 implementation for NFTs
import "openzeppelin/contracts/token/ERC721/ERC721.sol";
import "openzeppelin/contracts/access/Ownable.sol";

/**
 *@title RibsToken
 *@dev A contract to tokenize ribs, allowing ownership of a whole rack or individual ribs.
*/
contract RibsToken is ERC721, Ownable {
    // Counter for token IDs
    uint256 private _currentTokenId;

    // Mapping to track fractional ownership (rib by rib)
    mapping(uint256 => uint256) public ribToRack;

    /**
    * @dev Constuctor to initialize the contract with a name and symbol. 
    */
    constructor() ERC721("RibsToken", "RIBS") {}

    /**
     * @dev Mint a whole rack of ribs as a single token
     * @param to The address to receive the token.
     */
    function mintRack(address to) external onlyOwner {
        _currentTokenId++;
        _safeMint(to, _currentTokenId);
    }

    /**
    * @dev Mint an individual rib as a fractional token of a rack.
    * @param to The address to receive the token.
    * @param rackId The ID of the rack this rib belongs to.
     */
     function mintRib(address to, uint256 rackId) external onlyOwner {
        require(_exists(rackId), "Rack does not exist");
        _currentTokenId++;
        ribToRack[_currentTokenId] = rackId;
        _safeMint(to, _currentTokenId);
     }

     /**
      *@ */


}