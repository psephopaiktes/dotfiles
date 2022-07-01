# Windows Setting
- [ ] Ctrl+b,f,p,n,a,eはカーソル移動に。Alt+Aを全選択、Alt+b
  - [ ] [Windows 10でも「Emacs風キーバインド」を使おう【AutoHotKey】 | LFI](https://linuxfan.info/windows-emacs-keybindings)
  - [ ] [Windowsで好きなキーバインドを常に使えるようにする](https://zenn.dev/fss_bass/articles/40f222effd5ef2)みたいに、Ctrlはそのまま、Capslockとの連携だけ変える?
- [ ] Hiragino, SF

## TBD
- [ ] Winget
- [ ] Android APP
- [ ] GitHub Cli aptだとダメ、Brewが必要。

## STEP
1. Englishでスタート、MSサインイン、アップデート
2. 設定同期のためOne Drive サインインしとく
7. 言語を日本語に変更、Cleartypeで検索して設定
3. Powertoys設定
    - 常に管理者として実行
    - Caps → Ctrl 
    - Alt Q → Alt F4
    - その他ひととおり確認
4. Primary Apps を入れる、[App Setting 参考](https://github.com/psephopaiktes/dotfiles/blob/master/doc/app-setting.md)
    - [Chrome](https://www.google.co.jp/chrome/browser/desktop/index.html)
    - [Dropbox](https://www.dropbox.com/install)
    - [Google IME](https://www.google.co.jp/ime/)
5. コントロールパネル
  - 「ユーザーアカウント制御」を1段階下げる
  - 「エクスプローラのオプション」
      - 全般 → 「最近使ったファイルを...」「よく使うフォルダを...」OFF
      - 表示 → タイトルバーに完全なパスを表示
6. プライバシーとセキュリティから検索除外するフォルダを設定
7. MS Store → ライブラリから必要なソフトをインスコ
8. 設定→アプリ→スタートアップから選択
9. Start, Taskバーの整理
10. システム言語を英語に変更
14. [会社VPNの接続](https://wiki.unext-info.jp/pages/viewpage.action?pageId=71448379)

## WSL、Develop
1. Terminalで`wsl --install`
5. 再起動
6. ユーザー・パスを設定 Windowsと一緒にしとく。(hirat/ログオンPass)
8. `sudo apt update`→`sudo apt upgrade -y`
17. .zshrc, .git_config, .git_ignore を**WSLの**ユーザーフォルダに置いとく
    - Exploerのサイドバー`Linux`というのからいけるはず。Quick Accessにもピン留め
    - .zshrc 最後の方の行は消していい
    - `open`が使えるように、以下を.zshrcの末尾に追記
        ```
        function open() {
            if [ $# != 1 ]; then
                explorer.exe .
            else
                if [ -e $1 ]; then
                    cmd.exe /c start $(wslpath -w $1) 2> /dev/null
                else
                    echo "open: $1 : No such file or directory" 
                fi
            fi
        }
        ```
9. `sudo apt install zsh`
10. `which zsh` して、`chsh`の結果にそのパスを打つ→再起動
  - たぶん `chsh -s /usr/bin/zsh` になるはず
7. いちど `code .` するとCodeコマンドがインスコされる
16. VS CODEのターミナルが変わってなければ変更
13. https://github.com/psephopaiktes/dotfiles/blob/master/install.sh 参考に
14. Windows Terminal の設定からデフォルトシェルをWSLに



# app-list

アプリ | 設定項目
--|--
[Ricty Diminished](https://github.com/edihbrandon/RictyDiminished)  |  最新版を全ウェイトいれる
[Visual Studio Code](https://code.visualstudio.com/) | GitHub Sign In
[GitHub Desktop](https://desktop.github.com/) | 

## 保留
[Honeyview](https://www.bandisoft.com/honeyview/) | 
[VLC](https://www.videolan.org/vlc/index.ja.html) | 
[Explzh](https://www.ponsoftware.com/) | 
[Adobe CC](https://creativecloud.adobe.com/apps) | 
Hiragino Sans
