# dotfiles
- Macの環境構築用
- ドットファイルの数が少なく、ストアアプリについてのシンボリックリンク処理も行うのでほぼべた書き  
条件分岐やループほぼ無し
- brew cask は落とすバージョンが古かったりするのでなるたけ使わない

## TASK
- [ ] defaults コマンド
- [ ] brew cask
- [ ] git はある前提でいいかも

## 手順

1. [主要App](./doc/app-list.md)を入れる

2. システム環境設定を[変える](./doc/mac-setting.md)

3. 以下のコマンドを実行する。GitやZshをインスコ、dotfilesをデプロイします。
```
sudo bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/install.sh)"
```

4. [その他のApp](./doc/app-list.md)をインスコ､各種設定

5. その他のCUI設定、GoogleDrive内の設定ファイルをシンボリックリンク設定  
**GoogleDriveの同期後に実行すること｡**
```
~/.dotfiles/app-setting.sh
```

6. 見た目の整備
- Finderツールバーをカスタマイズ
  – 不要なものを消す
  - Chrome,PS,Codeを追加
- 壁紙を変える
- Dock整理、LaunchPad整理 
- 通知センター
  - SNS、天気、Music、計算機

7. Git Project
- ssh
