# dotfiles
- 平田のMac環境構築用
- English, zsh, ユーザー名は`a-hirata` 前提

## TBD
- [ ] install.sh が止まる
- [ ] zshに変更

## 手順

1. $ `xcode-select --install`

1. $ `sudo bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/deploy.sh)"`

1. $ `sudo bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/install.sh)"`
    - 要修正. １行ずつやるとうまくいく

1.  クリップボードの鍵を[GitHubのSSH keys](https://github.com/settings/ssh)に登録。不要なら古いのは消す。

1. [Macのシステム環境設定](./doc/mac-setting.md)

1. [アプリ設定](./doc/app-setting.md)  

1. Caskで扱えないのをインストール
    - [SF Font](https://developer.apple.com/fonts/)
    - [RictyDiminished](https://github.com/edihbrandon/RictyDiminished)
    - [サブセットフォントメーカー](https://opentype.jp/subsetfontmk.htm)
    - [WOFFコンバータ](https://opentype.jp/woffconv.htm)
    - [会社VPN](https://wiki.unext-info.jp/pages/viewpage.action?pageId=71448379)

1. アピアランスの整備
    - 壁紙を変える→5個に増やす
    - Finderツールバーをカスタマイズ
        – 不要なものを消す
        - Chrome,Ps,Ai,Codeを追加
        - DockでChromeを右クリック→オプション→特定のデスクトップのみに
        - DockでFinderを右クリック→オプション→すべてのデスクトップ
        - サイドバーを調整
            - デスクトップ
            - ダウンロード
            - AirDrop
            - アプリケーション
            - ホーム
            - グーグルドライブ
            - projects
    - Dock整理
    - 通知センターに Calendar、天気、計算機
    
1. ghコマンドの設定
    1. `$ gh auth login` -> ブラウザにコード入れてログインし、プロトコルにSSHを選択
    1. `$ gh config set editor "code --wait"` でエディタをVS CODEに設定

1. 再起動して終了


## Clean Install の手順

0. `~/projects`と`~/dotfiles`のGitファイル群はコミットしておく。DesktopやDownloadフォルダの退避

1. Music.app からサインアウト
    - メニューの「Account」からサインアウト

1. iCloud からサインアウト
    -  >「System Preference」>「Apple ID」
    - 「iCloud」タブで「Find My」を無効化
    - 「Overview」タブでサインアウト

1. Message.app からサインアウト
    - メニューの「Messages」>「Preferences」の「iMessage」タブからサインアウト
    
1. Sketchからサインアウト

1. ペアリングした Bluetooth デバイスをすべて削除

1. `⌘R` を押しながら起動

1. ディスクユーティリティを実行

1. `Macintosh HD` を選択して `消去` を実行。フォーマットはAPFSを選択

1. `Macintosh HD - Data` は削除（自動で作り直される）

1. macOSをインストールする

1. 初期設定。英語にする。
