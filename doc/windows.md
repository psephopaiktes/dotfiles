## TBD
- [ ] Android APP
- [ ] GitHub Cli aptだとダメ、Brewが必要。

## WinGet
- 先に手動インストール
    - Chrome
    - Google IME
    - [Explzh](https://www.ponsoftware.com/)
    - [LINE](https://apps.microsoft.com/store/detail/line/9WZDNCRFJ2G6)
- Search: `winget search`
- JSON Export: `winget export -o apps.json`
- JSON Import: `winget import -i apps.json --ignore-versions --accept-package-agreements --ignore-unavailable`


## STEP
1. Englishでスタート、MSサインイン、アップデート
1. 設定同期のためOne Drive サインインしとく
1. 言語を日本語に変更、Cleartypeで検索して設定
1. WinGet Install
1. Powertoys設定
    - 常に管理者として実行
    - Caps → Ctrl は Ctrl が押しっぱなし状態になってしまうバグがあるので、[Change Key](https://forest.watch.impress.co.jp/library/software/changekey/)を使ってレジストリからCtrl(Right)に変える
    - ![image](https://user-images.githubusercontent.com/4294850/176980594-c80ecee4-11c9-4bb3-aa93-35662c748127.png)
    - Dropbox/Appからバックアップを復元、その他ひととおり確認
1. [App Setting 参考](https://github.com/psephopaiktes/dotfiles/blob/master/doc/app-setting.md)
    1. Google IME の設定で「一般→キー設定の選択」でME-IMEを選んだあと、「編集」から[Ctrl Spaceによる切り替えを追加](https://kurobutasan.com/google-ime-ctrl-space/)
    1. Logi Optionの設定、トラックパッドの設定など
1. コントロールパネル
  - 「ユーザーアカウント制御」を1段階下げる
  - 「エクスプローラのオプション」
      - 全般 → 「最近使ったファイルを...」「よく使うフォルダを...」OFF
      - 表示 → タイトルバーに完全なパスを表示
1. プライバシーとセキュリティから検索除外するフォルダを設定
7. 設定→アプリ→スタートアップから選択
8. Start, Taskバーの整理
9. システム言語を英語に変更
10. [会社VPNの接続](https://wiki.unext-info.jp/pages/viewpage.action?pageId=71448379)

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
