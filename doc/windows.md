# Windows Setting

## TODO
ワンライナーなし。暫定版  
- [ ] https://smhn.info/202101-how-to-use-microsoft-windows-powertoys
- [ ] WSL
- [ ] Android APP
- [ ] [Microsoft公式ツール「Powertoys」を解説。なんでこの機能、Windowsに標準で入ってないの？という神機能が特盛！ - すまほん!!](https://smhn.info/202101-how-to-use-microsoft-windows-powertoys)
- [ ] [Windows11アップグレード後の動作を高速化(軽量化)する方法｜エンジニア目線](https://info-boxes.net/2021/11/02/windows11_performance/)
- [ ] https://www.google.com/search?q=WIndows+11+新機能
- [ ] Ctrl+b,f,p,n,a,eはカーソル移動に。Alt+Aを全選択、Alt+b
  - [ ] [Windows 10でも「Emacs風キーバインド」を使おう【AutoHotKey】 | LFI](https://linuxfan.info/windows-emacs-keybindings)
  - [ ] [Windowsで好きなキーバインドを常に使えるようにする](https://zenn.dev/fss_bass/articles/40f222effd5ef2)みたいに、Ctrlはそのまま、Capslockとの連携だけ変える?
- [ ] `cd /mnt/c/Users/a-hirata/prpjects`をbashrcとかに。WinだけのCODEターミナル設定同期したくない
- [ ] [Cap2Ctrlは公式のがあるぽい?]([Ctrl2cap | Microsoft Docs](https://docs.microsoft.com/ja-jp/previous-versions/bb897578(v=msdn.10)?redirectedfrom=MSDN))
- [ ] [Windows10でアプリを一括インストール／更新するなら「winget」 | 4thsight.xyz](https://4thsight.xyz/30394)

初期設定時に、**MSアカウントにログインしない**こと。ユーザーフォルダ名がおかしくなる。  
(5文字まででカットされてしまう仕様...)

ローカルアカウントでセットアップ後にサインイン。サインイン関連
- [Windows10 - 起動時のパスワード入力を省略 - 自動サインイン - PC設定のカルマ](https://pc-karuma.net/windows10-disable-password-login/)
- [Microsoftアカウント使用時に自動サインインできなくなってしまったら（Windows 10） | たまプラ通信](https://blog.naosan.jp/2017/04/8338/)

# 初期設定
- OSアップデート
- サインイン→基本的な設定は同期されるはず
- [Sモードを解除](http://snow-white.cocolog-nifty.com/first/2018/05/windows-10-sver.html)する
- [ClearTypeフォント](https://www.japan-secure.com/entry/how_to_change_the_system_font_of_windows_10.html)の設定をする
- コンパネ
  - 「ユーザーアカウント制御」を1段階下げる
  - 「エクスプローラのオプション」 → 「最近使ったファイルを...」「よく使うフォルダを...」OFF
- OneDriveサインイン→ログイン時に起動しない
- [Primary Apps](## Primary)を入れる
- クラウドストレージ選択同期
  - リムーバルメディアに入れる場合、Dropboxは[シンボリックリンクが必要](https://plaza.rakuten.co.jp/mscrtf/diary/201507060000/)
  - Dropbox内のポータブルアプリのショートカット追加
  - CapsをCtrlに
- 英字配列のキーボードで困ったら → [Windows10日本語版で英語配列キーボードを使用する - Qiita](https://qiita.com/shimizu14/items/000cceb9e72a492b9176)
- 各種アプリを入れる
- TBD スタートの構成 画像
- [パスワードや PIN の入力を省略して、Windows 10 に自動でサインインできるようにする方法 - ｋ本的に無料ソフト・フリーソフト](https://www.gigafree.net/Windows/No-Password-PIN-Sign-in/)


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
  - そのまま置くとパーミッションがないことが多いので、chmod 644とかしたほうがいいかも
11. nodebrewのインスコ `curl -L git.io/nodebrew | perl - setup`
  - `export PATH=$HOME/.nodebrew/current/bin:$PATH`を.bashrcに追加
12. nodeのインスコ `nodebrew install-binary stable` → `nodebrew use stable`
13. VS CODEのターミナル変更
  - `terminal.integrated.shell.windows": "C:/Windows/System32/wsl.exe"`

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
[Hyper™](https://hyper.is/) | .hyper.jsを読み込み

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
[VLC](https://www.microsoft.com/ja-jp/p/vlc/9nblggh4vvnh) | 
[コンセプト](https://www.microsoft.com/ja-jp/p/concepts/9ngqm8fph9wq?&activetab=pivot:overviewtab) |
