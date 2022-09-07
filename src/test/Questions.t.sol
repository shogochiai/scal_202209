// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "scal-std/BytesToUint.sol";
import "./ITestVars.sol";
import "../AnswerSheet.sol";
import "./IStructs.sol";
import "./YourNFT.sol";

contract Questions is Test, ITestVars {
    using stdStorage for StdStorage;
    using BytesToUint for bytes;

    IAnswerSheet yourContract;    
    YourNFT nft;
    function setUp() public {
        yourContract = IAnswerSheet(new AnswerSheet());
        nft = YourNFT(new YourNFT());
        yourContract.setNFT(address(nft));
        for(uint256 i; i < 100;) {
            nft.mintItem(address(yourContract));
            unchecked { ++i; }
        }
    }

    function testArithmetic() public {
        Test1Vars memory vars;

        vars.tempGas = gasleft();
        (, vars.resultBytes) = address(yourContract).call(abi.encodeWithSelector("calc"));
        vars.result = vars.resultBytes.toUint();
        console.log(vars.result); // Note: Try me, and remove me later ;)
        vars.execGas = vars.tempGas - gasleft();

        assertTrue(vars.result == 115792089237316195423570985008687907853269984665640564039457584007913129639935);
        console.log(vars.execGas);
        assertTrue(vars.execGas < 8000); // Note: ただし上記の値をそのままコピペすることは無効です
    }

    function testStructAndStorage() public {
        Test2Vars memory vars;
        IStructs.YourScore memory _score;
        _score.name = "John Doe";
        _score.description = "This is a sample score.";
        _score.score = 50;

        yourContract.submitScoreWithCheat(_score);

        vars.slot = stdstore
                        .target(address(yourContract))
                        .sig(yourContract.scores.selector)
                        .with_key(address(this))
                        .depth(2) // Note: Struct getter returns array of members
                        .find();
        assertEq(uint256(vm.load(address(yourContract), bytes32(vars.slot))), 100);

        /*
            Hint:
                このテストはストレージに狙った値が入っていることをテストしています。
                したがって、ストレージを検査するために外部からストレージを閲覧できるようにしてあげる必要があります。
                Solidityにおいてことなるコントラクトを叩くときは、インターフェースを用います。
                インターフェースはコンパイラに型情報をよりたくさん与えられるので、
                コンパイラが人間の代わりにミスを発見してくれる良さもあります。
        */
    }

    function testConditionalCheck() public {
        Test3Vars memory vars; // Note: structに一時変数を保存するクセをつけておくと "Stack too deep" に泣かされないで済むぞ。（メモリ空間上のスロットは有限リソース）


        /*
            ストーリーサンプル
                - 100万ドルの不動産を担保にドルを借りてるイメージ
                - 担保率=100*担保/負債
                - 不動産価値が落ちて担保率110%くらいになったら現物を抑える(実装しなくてよい)
                - 担保率110%以下になるようなポジションは許さない
        */
        vars.alice.addr = vm.addr(1);
        vars.alice.collateral = 100;
        vars.alice.debt = 0;
        vars.bob.addr = vm.addr(2);
        vars.bob.collateral = 150;
        vars.bob.debt = 10;
        vars.carl.addr = vm.addr(3);
        vars.carl.collateral = 200;
        vars.carl.debt = 200;

        vm.prank(vars.alice.addr);
        vm.expectRevert(abi.encodePacked("Collateralization ratio must be more than 110%"));
        vars.result1 = yourContract.borrowMore(vars.alice, 100);

        vm.prank(vars.alice.addr);
        vm.expectRevert(abi.encodePacked("You are not the owner of this account."));
        vars.result1 = yourContract.borrowMore(vars.bob, 100);

        vm.prank(vars.bob.addr);
        vars.result2 = yourContract.borrowMore(vars.bob, 120);

        vm.prank(vars.carl.addr);
        vm.expectRevert(abi.encodePacked("Collateralization ratio is already too high"));
        vars.result3 = yourContract.borrowMore(vars.carl, 100);

        assertEq(vars.result1, false);
        assertEq(vars.result2, true);
        assertEq(vars.result3, false);
    }

    function testNativeToken() public {
        Test4Vars memory vars;

        vars.alice.addr = vm.addr(1);
        vars.alice.score = 100;
        vm.deal(vars.alice.addr, 1 ether);
        vars.bob.addr = vm.addr(2);
        vars.bob.score = 60;
        vm.deal(vars.bob.addr, 2 ether);

        vm.prank(vars.alice.addr);
        yourContract.gimmeLicense(vars.alice);

        vm.prank(vars.bob.addr);
        vm.expectRevert(abi.encodePacked("You failed."));
        yourContract.gimmeLicense(vars.bob);

        vm.prank(vars.bob.addr);
        vm.expectRevert(abi.encodePacked("You failed."));
        yourContract.gimmeLicense{value: 1e17}(vars.bob);

        (, vars.score) = yourContract.licenseHolders(vars.bob.addr);
        assertTrue(vars.score == 0);

        vm.prank(vars.bob.addr);
        yourContract.gimmeLicense{value:1 ether}(vars.bob);

        (, vars.score) = yourContract.licenseHolders(vars.bob.addr);
        assertTrue(vars.score == vars.bob.score);
    }

    function testNFT() public {
        Test5Vars memory vars;

        vars.alice.addr = vm.addr(1);
        vm.deal(vars.alice.addr, 2 ether);
        vars.bob.addr = vm.addr(2);
        vm.deal(vars.bob.addr, 2 ether);

        vm.prank(vars.alice.addr);
        yourContract.buyBoosterPack{value:1 ether}();
        vars.balance = nft.balanceOf(vars.alice.addr);
        assertTrue(vars.balance == 5);

        vm.prank(vars.bob.addr);
        yourContract.buyBoosterPack{value:1 ether}(); // 売るためのNFTはこのテストファイル先頭setUp関数で用意してある.
        vars.balance = nft.balanceOf(vars.bob.addr);
        assertTrue(vars.balance == 5);

        vm.prank(vars.alice.addr);
        vars.canEnter = yourContract.originHolderCanEnter();
        assertTrue(vars.canEnter);

        vm.prank(vars.bob.addr);
        vm.expectRevert(abi.encodePacked("You don't have the first NFT."));
        yourContract.originHolderCanEnter();
    }


}
