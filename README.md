# Smart Contract Application Laboratory - Lecture 14, 15

## Getting Started

### ベース環境
- WindowsはWSL2を用意。MacOSはTerminalを用意。
  - WSL(1)はUbuntu18.04なのでFoundryが未対応
- Foundryのダウンロード
  - `curl -L https://foundry.paradigm.xyz | bash`
  - インストール: `foundry up`
    - (もうリポジトリに入れてあるが必要なら) 依存ライブラリのインストール
      - `forge install foundry-rs/forge-std`
      - `forge install transmissions11/solmate`

## NFTスマートコントラクトテンプレートの用意
- (zipファイルでこのプロジェクトを渡した場合は初めから入っている)
- NodeJSのインストールとopenzeppelinのインストール
  - Ubuntu (on Windows)の人
    - https://joshtronic.com/2020/04/21/how-to-install-nodejs-14-on-ubuntu-1604-lts/
  - MacOSの人
    - https://nodejs.org/download/release/v14.16.1/node-v14.16.1-darwin-x64.tar.gz
  - その他の方法：NodeJSの最新のLTS (long term support)版をインストールする
    - https://nodejs.org/en/
  - NodeJSをインストールできたら `npm i`

## 開発エディタ
- エディタはMacOS/UbuntuならばVSCode推奨. Solidity pluginをextentionsから追加して、key remappingで
  - `"forge-std/=lib/forge-std/src/",`
  - `"@openzeppelin/contracts=node_modules/openzeppelin-contracts/"`
  - の二行を追加するとエディタ上でエラーが出ない
- Windows (WSL)ならばVSCodeは工夫をしないと使いにくいのでVi/Vimを推奨
  - Pathogenというvimパッケージマネージャーをインストールする
  - Solidityシンタックスハイライトを効かせる https://github.com/tomlion/vim-solidity

## 進め方
- `./src/test/Questions.t.sol` は単体テストフレームワークを応用した問題集になっている
- `forge test -vv -m <テスト名>` コマンドを使用して「答案用紙を実行」して、テストを通過するようにプログラムを埋めよう
  - テスト実行コマンドいろいろ
  - `forge test -vv -m testArithmetic`
  - `forge test -vv -m testStructAndStorage`
  - `forge test -vv -m testConditionalCheck`
  - `forge test -vv -m testNativeToken`
  - `forge test -vv -m testNFT`
  - `forge test -vv` 失敗したテストだけ簡易に結果が出る
  - `forge test -vvv` 失敗したテストだけスタックトレースも出る
  - `forge test -vvvv` 全てのテストが簡易に結果が出る
  - `forge test -vvvvv` 全てのテストがスタックトレースも出る

## Lecture 14
・スマートコントラクトのテスト駆動開発を覚える
・不動小数点の四則演算を試す/gasleft()とconsole.log()を学ぶ
・構造体/ストレージアクセスを試す
・制御構文(if, for, require, revert), modifier, アクセス制御, オーナー権限を試す

## Lecture 15
・ネイティブトークン支払いを試す
・ERC-721とapprovalとプログラマブルな送金と多様なコントラクト
・デプロイを試す

