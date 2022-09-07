// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "../test/IStructs.sol";

interface IAnswerSheet {
  function calc() external pure returns (uint256);
  function submitScoreWithCheat(IStructs.YourScore memory) external;
  function scores(address _key) external returns (string memory, string memory, uint256);
  function borrowMore(IStructs.Person memory person, uint256 amount) external returns (bool);
  function gimmeLicense(IStructs.LicenseCandidate memory candidate) external payable;
  function licenseHolders(address _key) external returns (address, uint256);
  function setNFT(address _nft) external;
  function buyBoosterPack() external payable;
  function originHolderCanEnter() external returns (bool);
}
