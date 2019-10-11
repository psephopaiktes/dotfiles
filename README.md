# dotfiles
- 平田のMac環境構築用
- English前提

## 手順

1. $ `xcode-select --install`

1. $ `sudo bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/deploy.sh)"`

1. $ `sudo bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/install.sh)"`
    - 要修正

1.  クリップボードの鍵を[GitHubのSSH keys](https://github.com/settings/ssh)に登録。不要なら古いのは消す。

1. [Macのシステム環境設定](./doc/mac-setting.md)

1. [アプリ設定](./doc/app-setting.md)  
// [BST](https://itunes.apple.com/jp/app/bettersnaptool/id417375580)必要?

1. [Apple](https://developer.apple.com/fonts/) からSFフォントをすべて入れる

1. アピアランスの整備
    - Finderツールバーをカスタマイズ
        – 不要なものを消す
        - Chrome,Ps,Ai,Codeを追加
    - 壁紙を変える
    - Dock整理
    - 通知センターに Calendar、天気、計算機

1. 再起動して終了


## Clean Install の手順

1. Music.app からサインアウト
    - メニューの「Account」からサインアウト

1. iCloud からサインアウト
    -  >「System Preference」>「Apple ID」
    - 「iCloud」タブで「Find My」を無効化
    - 「Overview」タブでサインアウト

1. Message.app からサインアウト
    - メニューの「Messages」>「Preferences」の「iMessage」タブからサインアウト
    
1. ペアリングした Bluetooth デバイスをすべて削除

1. `⌘R` を押しながら起動

1. ディスクユーティリティを実行

1. `Macintosh HD` を選択して `消去` を実行。フォーマットはAPFSを選択

1. `Macintosh HD - Data` を選択して `消去` を実行。フォーマットはAPFSを選択

1. macOSをインストールする

1. 初期設定。英語にする。
