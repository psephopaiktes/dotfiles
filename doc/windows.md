ワンライナーなし。暫定版

# 初期設定
- OSアップデート
- サインイン→基本的な設定は同期されるはず
- [Sモードを解除](http://snow-white.cocolog-nifty.com/first/2018/05/windows-10-sver.html)する
- コンパネ
  - 「ユーザーアカウント制御」を1段階下げる
  - 「エクスプローラのオプション」 → 「最近使ったファイルを...」「よく使うフォルダを...」OFF
- OneDriveサインイン→ログイン時に起動しない
- Primary Appsを入れる
- クラウドストレージ選択同期
  - リムーバルメディアに入れる場合、Dropboxは[シンボリックリンクが必要](https://plaza.rakuten.co.jp/mscrtf/diary/201507060000/)
  - ポータブルアプリのショートカット追加
- CapsをCtrlに
- 英字配列のキーボードで困ったら → [Windows10日本語版で英語配列キーボードを使用する - Qiita](https://qiita.com/shimizu14/items/000cceb9e72a492b9176)
- 各種アプリを入れる
- TBD スタートの構成 画像
- iTunesシンボリックリンク

## Ubuntu + VS CODE + Zsh
0. VS CODEをインスコしとく
1. WIn+R→「appwiz.cpl」
2. 「Turn Windows feature on or off」
3. 「Windows Subsystem for Linux」on → Restart
4. Windowsストアで「Linux」と検索 → Ubuntuをインスコ
5. Ubuntuを起動 しばらく時間がかかる
6. ユーザー・パスを設定
7. `sudo apt update`→`sudo apt upgrade -y`
8. `sudo apt install zsh`
9. `which zsh` して、`chsh`の結果にそのパスを打つ→Ubuntu再起動
10. .zshrc, .git_configなどを置く
  - `C:\Users\{User}\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_*\LocalState\rootfs\home\{User}` にある
  - `open`が使えるように、`alias open="cmd.exe /c start"`を追加(WSLのは開けない)
11. nodebrewのインスコ `curl -L git.io/nodebrew | perl - setup`
  - `export PATH=$HOME/.nodebrew/current/bin:$PATH`を.bashrcに追加
12. nodeのインスコ `nodebrew install-binary stable` → `nodebrew use stable`

### TMP Memo
`cd /mnt/c/Users/a-hirata/prpjects`をbashrc

# app-list

## Primary
アプリ | 設定項目
--|--
[Chrome](https://www.google.co.jp/chrome/browser/desktop/index.html)  |  ログイン、DL先をデスクトップに
[Google Drive](https://www.google.com/drive/download/)  |  同期するフォルダを選択、USBデバイスとSDカードのチェック外す
[Dropbox](https://www.dropbox.com/install)  |   同期するフォルダを選択、 Not launch at login
[Google IME](https://www.google.co.jp/ime/)  |  入力補助 -「、。」「・「」」など意外は全部半角入力に<br>一般-候補選択ショートカット-A--L<br>一般-キ-設定の選択-MSIME<br>辞書をインポート<br>[Ctrl Spaceで切り替えられるようにしておく](http://d.hatena.ne.jp/ang65/20110409/1302316109)


## Font
アプリ | 設定項目
--|--
[Ricty Diminished](http://www.rs.tus.ac.jp/yyusa/ricty_diminished.html)  | 最新版を全ウェイトいれる
[Google Noto Fonts](https://www.google.com/get/noto/#sans-jpan) | 

## Dev
アプリ | 設定項目
--|--
[Visual Studio Code](https://code.visualstudio.com/) | [SettingSync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)入れて[TOKEN入力し](https://github.com/settings/tokens)、`⌥⇧D`で設定落とす→自動UP,DLにしとく。パレットでShellって検索→インスコ
[Opera](http://www.opera.com/ja)  |  
[Vivaldi](https://vivaldi.com/?lang=ja_JP)  |  
[Firefox](https://www.mozilla.org/ja/firefox/new/)  |  ログイン
[WinSCP](https://winscp.net/eng/download.php) | 

## Design
アプリ | 設定項目
--|--
[CLIP STUDIO](https://www.clip-studio.com/clip_site/rental/rental_download/sprental/)  |   起動初期設定､ログイン､PAINT起動→[アクティベート](https://www.clip-studio.com/clip_site/tool/manage/store)
[FontBase](https://fontba.se/) | GoogleDriveのフォントを読み込んでおく
[Figma](https://www.figma.com/download/desktop/mac) / [Fonts](https://www.figma.com/settings) | ログイン
[Honeyview](https://www.bandisoft.com/honeyview/) | 

## Other
アプリ | 設定項目
--|--
[QuickLook](https://github.com/QL-Win/QuickLook/releases) | 
[Kindle](https://www.amazon.co.jp/kindleapps)  |  
[Explzh](https://www.ponsoftware.com/) | 
[VLC](https://www.videolan.org/vlc/index.ja.html) | 
[SKYBOX](https://skybox.xyz/en/download/) | 
[Steam](https://store.steampowered.com) | ログイン

## Windows Store
アプリ | 設定項目
--|--
[Netflix](https://www.microsoft.com/ja-jp/p/netflix/9wzdncrfj3tj) | 
[LINE](https://www.microsoft.com/ja-jp/p/line/9wzdncrfj2g6) | 
[iTunes](https://www.microsoft.com/ja-jp/p/itunes/9pb2mz1zmb1s) | 
[U-NEXT](https://www.microsoft.com/ja-jp/p/u-next-%E3%83%A6%E3%83%BC%E3%83%8D%E3%82%AF%E3%82%B9%E3%83%88-%E6%98%A0%E7%94%BB-%E3%83%89%E3%83%A9%E3%83%9E-%E3%82%A2%E3%83%8B%E3%83%A1%E3%81%AA%E3%81%A9%E8%A6%8B%E6%94%BE%E9%A1%8C/9nblggh52267) | 
Dropbox | 
[VLC](https://www.microsoft.com/ja-jp/p/vlc/9nblggh4vvnh) | 
