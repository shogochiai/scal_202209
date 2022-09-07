// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IStructs {
  struct YourScore {
    string name;
    string description;
    uint256 score;
  }

  struct Person {
    address addr;
    uint256 collateral;
    uint256 debt;
  }

  struct LicenseCandidate {
    address addr;
    uint256 score;
  }

}
