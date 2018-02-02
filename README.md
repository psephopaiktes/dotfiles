# dotfiles (WIP)
- Macの環境構築用
- ドットファイルの数が少なく、ストアアプリについてのシンボリックリンク処理も行うのでほぼべた書き  
条件分岐やループほぼ無し
- brew cask は落とすバージョンが古かったりするのでなるたけ使わない

## 手順

1. [主要App](./doc/app-list.md)を入れる

2. システム環境設定を[変える](./doc/mac-setting.md)

3. GitやZshをインスコ、dotfilesをデプロイ
```
bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/install.sh)"
```

4. [その他のApp](./doc/app-list.md)をインスコ

5. その他のCUI設定、GoogleDrive内の設定ファイルをシンボリックリンク設定
```
~/.dotfiles/app-setting.sh
```

6. Dock整理、デスクトップ整理
### ツールバーをカスタマイズ
–　不要なものを消す
−　Ps,Code,Chromeを追加
(画像)
- 壁紙を変える
- MissionControlを整理 
