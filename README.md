- [ ] Desktop Widget良さそう。色は変えてもいいかも

# dotfiles

[@psephopaiktes](https://github.com/psephopaiktes/) のMac初期設定用


<br /><br />


## 既存の端末を初期化する場合 (任意)

### 事前準備
1. `~/projects`配下のローカルリポジトリ群は変更をPushしておく。DesktopやDownloadフォルダのバックアップ。
1. Music.app からサインアウト
    - メニューの`Account`からサインアウト
1. Message.app からサインアウト
    - メニューの`Messages`>`Preferences`の`iMessage`タブからサインアウト
1. iCloud からサインアウト
    - `` >`System Preference` > 自分のApple IDを選択
    - `iCloud`で`Find My`を無効化
    - 最下部からサインアウト
1. ペアリングした Bluetooth デバイスをすべて削除

### 初期化

[Macを消去して工場出荷時の初期設定にリセットする - Apple サポート (日本)](https://support.apple.com/ja-jp/102664)

※ OSに対応した最新の情報を確認する
※ 初期設定時は**いったん英語ですすめる**ことを推奨


<br /><br />


## 初期設定手順

1. Gitを使えるようにするために Command Line Tools をインストールして同意
    ```zsh
    xcode-select --install
    ```
    ```zsh
    sudo xcodebuild -license
    ```

1. 以下のワンライナーを実行。定期的にパスワード入力を求められる。かなり時間はかかるので、後述の手動設定を並行してやるのを推奨。Caskで必要になるので、AppleIDはサインインしとくと良いかも。
    ```zsh
    sudo curl -fsSL https://raw.githubusercontent.com/psephopaiktes/dotfiles/main/init.sh | zsh
    ```
    以下が自動実行されます
    - このリポジトリをCloneする（既にある場合はpull）
    - そのまま `make all` でシェルスクリプトを実行する
    - **終わったらいちど再起動推奨**

1. ルートに生成された`.env`の中身を以下のメモに変更
    - 🔒[Craft.do](https://docs.craft.do/editor/d/05090509-c69e-9719-2d99-81ea48b7173d/A304B6B8-A329-49D4-9F46-B4AC63B165E8?s=YvSeefcPbwjhAHj2nzyrjfYLxU2jPp3YbPi94hpsmLed)

1. [Macのシステム環境設定](./doc/mac-setting.md)

1. [アプリ設定](./doc/app-setting.md)  

1. Homebrewで扱えないアプリをインストール
    - 前回失敗したやつ:
        - [Adobe CC](https://creativecloud.adobe.com/apps) 
        - [Logicool Options](https://www.logicool.co.jp/ja-jp/product/options)
        - [Material Icon](https://github.com/google/material-design-icons)
    - 今回失敗
        - Skybox
    - [サブセットフォントメーカー](https://opentype.jp/subsetfontmk.htm)
    - [WOFFコンバータ](https://opentype.jp/woffconv.htm)

1. 再起動して終了


<br /><br />


## `.bin/` を更新した時

新規ファイル追加や更新したら、次を実行してシンボリックリンクを更新
```zsh
zsh ~/projects/dotfiles/shell/link.sh
```
