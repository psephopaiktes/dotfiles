# dotfiles
- Macの環境構築用
- 一般的なDotfilesよりもイモい


## デプロイ
- ドットファイルの数が少なく、GUIについてのシンボリックリンク処理も行うのでfor文は使っていない
- brew cask は落とすバージョンが古かったりするので使いすぎない

## 新環境での手順
## 流れ

1. 主要 GUIを入れる
  - [Chrome](), バックアップと同期、GoogleIME、AppCleanerをインスコ  
  →設定を変える、同期しとく
  - Xcodeインスコ、Dockにシミュレータ置く

2. システム環境設定を[変える](./mac-setting.md)

3. `bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/install.sh)"`

4. [その他のApp](app-list.md)をインスコ

5. app-setting.sh を実行
