# dotfiles
平田のMac環境構築用


## 手順

- [ ] 次の環境では[asdf](https://github.com/asdf-vm/asdf)か[mise](https://github.com/jdx/mise)にしたい。基本miseが良さそうだけど、asdfがGOになってるならありかも。Winにも対応してて欲しい。

1. Mac本体Versionを最新版にしておく

1. $ `xcode-select --install`

1. $ `bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/deploy.sh)"`
    - GitHubはあとからCLIで認証。ssh-keygenはしない。 →もしかして最初にやらないとbash -c動かない?

1. $ `bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/install.sh)"`
    - [ ] 要修正. １行ずつやるとうまくいく

1. [Macのシステム環境設定](./doc/mac-setting.md)

1. [アプリ設定](./doc/app-setting.md)  

1. Caskで扱えないアプリをインストール(一応探してみる)
    - [Adobe CC](https://creativecloud.adobe.com/apps)
    - [サブセットフォントメーカー](https://opentype.jp/subsetfontmk.htm)
    - [WOFFコンバータ](https://opentype.jp/woffconv.htm)
    - [会社VPN設定](https://wiki.unext-info.jp/pages/viewpage.action?pageId=71448379)
    - [Logicool Options](https://www.logicool.co.jp/ja-jp/product/options)
    - [Material Icon](https://github.com/google/material-design-icons)
    - [morisawa-biz-ud-gothic](https://github.com/googlefonts/morisawa-biz-ud-gothic/)
    - [morisawa-biz-ud-mincho](https://github.com/googlefonts/morisawa-biz-ud-mincho/)

1. 再起動して終了, 最後にLogin Items と Background Process の整理


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
