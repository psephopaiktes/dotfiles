# dotfiles

[@psephopaiktes](https://github.com/psephopaiktes/) のMac初期設定用


<br /><br />


## 既存の端末を初期化する場合 (任意)

### 事前準備
1. `~/projects`配下のローカルリポジトリ群は変更をPushしておく。DesktopやDownloadフォルダのバックアップ。
1. Music.app からサインアウト
    - メニューの`Account`からサインアウト
1. iCloud からサインアウト
    - `` >`System Preference` >`Apple ID`
    - `iCloud`タブで`Find My`を無効化
    - `Overview`タブでサインアウト
1. Message.app からサインアウト
    - メニューの`Messages`>`Preferences`の`iMessage`タブからサインアウト
1. ペアリングした Bluetooth デバイスをすべて削除

### 初期化
※ 最新の情報を確認してください。
1. `⌘R` を押しながら起動
1. ディスクユーティリティを実行
1. `Macintosh HD` を選択して `消去` を実行。フォーマットはAPFSを選択
1. `Macintosh HD - Data` は削除（自動で作り直される）
1. macOSをインストールする
1. 初期設定。**いったん英語にしとく**


<br /><br />


## 初期設定手順

1. 
    ```zsh
    curl -fsSL https://raw.githubusercontent.com/psephopaiktes/dotfiles/master/init.sh | zsh
    ```
    このワンライナーで以下が実行されます
    - このリポジトリをCloneする（既にある場合はpull）
    - そのまま `make all` でシェルスクリプトを実行する

1. ルートに生成された`.env`の中身を以下のメモに変更
    - 🔒[Craft.do](https://docs.craft.do/editor/d/05090509-c69e-9719-2d99-81ea48b7173d/A304B6B8-A329-49D4-9F46-B4AC63B165E8?s=YvSeefcPbwjhAHj2nzyrjfYLxU2jPp3YbPi94hpsmLed)

1. [Macのシステム環境設定](./doc/mac-setting.md)

1. [アプリ設定](./doc/app-setting.md)  

1. Homebrewで扱えないアプリをインストール
    - 前回失敗したやつ:
        - [Adobe CC](https://creativecloud.adobe.com/apps) 
        - [Logicool Options](https://www.logicool.co.jp/ja-jp/product/options)
        - [Material Icon](https://github.com/google/material-design-icons)
    - [サブセットフォントメーカー](https://opentype.jp/subsetfontmk.htm)
    - [WOFFコンバータ](https://opentype.jp/woffconv.htm)

1. 再起動して終了


<br /><br />


## `.bin/` を更新した時

新規ファイル追加や更新したら、次を実行してシンボリックリンクを更新
```zsh
zsh ~/projects/dotfiles/shell/link.sh
```
