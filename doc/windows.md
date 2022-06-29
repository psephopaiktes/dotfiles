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

- [Primary Apps](## Primary)を入れる


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
