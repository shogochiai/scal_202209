// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "../test/IStructs.sol";

interface ITestVars {
  struct Test1Vars {
    uint256 tempGas;
    uint256 execGas;
    uint256 result;
    bytes resultBytes;
  }

  struct Test2Vars {
    uint256 slot;
  }

  struct Test3Vars {
    IStructs.Person alice;
    IStructs.Person bob;
    IStructs.Person carl;
    bool result1;
    bool result2;
    bool result3;
  }

  struct Test4Vars {
    IStructs.LicenseCandidate alice;
    IStructs.LicenseCandidate bob;
    uint256 score;
  }

  struct Test5Vars {
    IStructs.Person alice;
    IStructs.Person bob;
    uint256 balance;
    bool canEnter;
  }
}
