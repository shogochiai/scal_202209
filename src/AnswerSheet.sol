// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import '@openzeppelin/contracts/token/ERC721/IERC721.sol';
import "./interfaces/IAnswerSheet.sol";
import "./test/IStructs.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AnswerSheet is IAnswerSheet, Ownable {
  function calc() external pure override returns (uint256) {
    return 42; // Note: Fix me!
  }

  function scores(address _key) external returns (string memory, string memory, uint256) {}
  function submitScoreWithCheat(IStructs.YourScore memory _score) external override {
    // Note: Fill me!
  }

  function borrowMore(IStructs.Person memory person, uint256 amount) external override onlyYou(person) returns (bool) {
    return true; // Note: Fix me!
  }
  modifier onlyYou(IStructs.Person memory person) {
    _;
  }


  mapping(address=>IStructs.LicenseCandidate) public licenseHolders;
  function gimmeLicense(IStructs.LicenseCandidate memory candidate) external payable override onlyYou2(candidate) {
    require(candidate.score > 80, "You failed.");
    licenseHolders[msg.sender] = candidate;
  }
  modifier onlyYou2(IStructs.LicenseCandidate memory candidate) {
    require(msg.sender == candidate.addr, "You are not the owner of this account.");
    _;
  }

  IERC721 nft;
  function setNFT(address _nft) public override onlyOwner {
    nft = IERC721(_nft);
  }
  uint256 _boosterCounter = 1;
  function buyBoosterPack() public payable override {
    // Note: Fill me
  }
  function originHolderCanEnter() public override returns (bool) {
    // Note: Fill me
  }


}

