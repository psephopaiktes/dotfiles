# Windows Setting

## TBD
- [ ] Winget

## TODO
ワンライナーなし。暫定版  
- [ ] WSL
- [ ] Android APP
- [ ] https://www.google.com/search?q=WIndows+11+新機能
- [ ] Ctrl+b,f,p,n,a,eはカーソル移動に。Alt+Aを全選択、Alt+b
  - [ ] [Windows 10でも「Emacs風キーバインド」を使おう【AutoHotKey】 | LFI](https://linuxfan.info/windows-emacs-keybindings)
  - [ ] [Windowsで好きなキーバインドを常に使えるようにする](https://zenn.dev/fss_bass/articles/40f222effd5ef2)みたいに、Ctrlはそのまま、Capslockとの連携だけ変える?
- [ ] `cd /mnt/c/Users/a-hirata/prpjects`をbashrcとかに。WinだけのCODEターミナル設定同期したくない

## STEP
- [Primary Apps](## Primary)を入れる
1. Englishでスタート、MSサインイン、アップデート
1. 設定同期のためOne Drive サインインしとく
1. 言語を日本語に変更、Cleartypeで検索して設定
1. コントロールパネル
  - 「ユーザーアカウント制御」を1段階下げる
  - 「エクスプローラのオプション」
      - 全般 → 「最近使ったファイルを...」「よく使うフォルダを...」OFF
      - 表示 → タイトルバーに完全なパスを表示
1. プライバシーとセキュリティから検索除外するフォルダを設定
1. [App Setting 参考](https://github.com/psephopaiktes/dotfiles/blob/master/doc/app-setting.md)
    - IMEをCtrl Spaceで切り替えられるようにする→キー設定の選択から「IMEを無効化」「IMEを有効化」をすべてCtrl Spaceに

1. 英字配列のキーボードで困ったら → [Windows10日本語版で英語配列キーボードを使用する - Qiita](https://qiita.com/shimizu14/items/000cceb9e72a492b9176)

設定→アプリ→スタートアップから選択

1. OneDriveログイン時に起動しない
1. TBD スタートの構成 画像
1. システム言語を英語に変更

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
[Dropbox](https://www.dropbox.com/install)  |   同期するフォルダを選択
[Google IME](https://www.google.co.jp/ime/)  |  入力補助 -「、。」「・「」」など意外は全部半角入力に<br>一般-候補選択ショートカット-A--L<br>一般-キ-設定の選択-MSIME<br>辞書をインポート<br>[Ctrl Spaceで切り替えられるようにしておく](http://d.hatena.ne.jp/ang65/20110409/1302316109)


## Font
アプリ | 設定項目
--|--
[Ricty Diminished](http://www.rs.tus.ac.jp/yyusa/ricty_diminished.html)  |  最新版を全ウェイトいれる


## Dev
アプリ | 設定項目
--|--
[Visual Studio Code](https://code.visualstudio.com/) | GitHub Sign In
[Hyper™](https://hyper.is/) | .hyper.jsを読み込み
GhDesktop
Gh
Slack

## Design
アプリ | 設定項目
--|--
[Figma](https://www.figma.com/download/desktop/mac) / [Fonts](https://www.figma.com/settings) | ログイン
[Honeyview](https://www.bandisoft.com/honeyview/) | 
Adobe

## Other
アプリ | 設定項目
--|--
[QuickLook](https://github.com/QL-Win/QuickLook/releases) | 
[Explzh](https://www.ponsoftware.com/) | 
[VLC](https://www.videolan.org/vlc/index.ja.html) | 
[Steam](https://store.steampowered.com) | ログイン
Microsoft Security Essentials3.74


## Windows Store
アプリ | 設定項目
--|--
[Netflix](https://www.microsoft.com/ja-jp/p/netflix/9wzdncrfj3tj) | 
[LINE](https://www.microsoft.com/ja-jp/p/line/9wzdncrfj2g6) | 
[VLC](https://www.microsoft.com/ja-jp/p/vlc/9nblggh4vvnh) | 
[コンセプト](https://www.microsoft.com/ja-jp/p/concepts/9ngqm8fph9wq?&activetab=pivot:overviewtab) |
