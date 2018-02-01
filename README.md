# dotfiles
- Macの環境構築用
- 一般的なDotfilesよりもイモい
- ドットファイルの数が少なく、ストアアプリについてのシンボリックリンク処理も行うのでほぼべた書き
- brew cask は落とすバージョンが古かったりするのでなるたけ使わない

## 新環境での手順

1. [主要App](./doc/app-list.md)を入れる

2. システム環境設定を[変える](./doc/mac-setting.md)

3. `bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/install.sh)"`

4. [その他のApp](./doc/app-list.md)をインスコ

5. `~/.dotfiles/app-setting.sh`

6. Dock整理、デスクトップ整理
(画像)
