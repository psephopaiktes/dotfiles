## TBD
- [ ] Android APP
- [ ] https://twitter.com/zmukkuri/status/1651151599853772802
- [ ] プライバシー系
    - [ ] Media Player 最近使ったファイル →消せなそうだから他のアプリかなあ VLC?
    - [ ] Dropbox やOther検索にヒットさせない
    - [ ] 漫画Viewer



## STEP
1. Englishでスタート？、MSサインイン、「以前のPCから設定を引き継ぐ」
2. 設定同期のためOne Driveに最初だけサインインしとく
3. ひたすらアップデート
4. Option: 言語を日本語に変更、Cleartypeで検索して設定
5. apps.json落として[WinGetでInstall↓](#WinGet)
6. Powertoys設定
    - 常に管理者として実行
    - Caps → Ctrl は Ctrl が押しっぱなし状態になってしまうバグがあるので、[Change Key](https://forest.watch.impress.co.jp/library/software/changekey/)を使ってレジストリからCtrl(Right)に変える
    - ![image](https://user-images.githubusercontent.com/4294850/176980594-c80ecee4-11c9-4bb3-aa93-35662c748127.png)
    - Dropbox/Appからバックアップを復元、その他ひととおり確認
7. [App Setting 参考](https://github.com/psephopaiktes/dotfiles/blob/master/doc/app-setting.md)
    1. Google IME の設定で「一般→キー設定の選択」でインポート. アプリを再起動するまでは反映されないので注意
    1. Logi Optionの設定、トラックパッドの設定など
8. コントロールパネル
    - 「ユーザーアカウント制御」を1段階下げる
9. デスクトップ右クリック→個人用設定→テーマ→ゴミ箱アイコンを非表示にする
10. エクスプローラのオプション
    - 全般 → 「最近使ったファイルを...」「よく使うフォルダを...」OFF
    - 表示 → タイトルバーに完全なパスを表示
    - 表示 → 隠しファイルの表示、拡張子の表示
11. プライバシーとセキュリティから検索除外するフォルダを設定
12. 設定→アプリ→スタートアップから選択
13. Start, Taskバーの整理
14. システム言語を英語に変更
15. Clear Type を検索して設定
16. [会社VPNの接続](https://wiki.unext-info.jp/pages/viewpage.action?pageId=71448379)

## シンクライアント運用
- ホスト
    - 設定のリモートから有効化する
    - Remote Desktop の場合、3本指タップが意図通りにならない場合もある。その場合はDropbox/AppのRegファイルを実行
- クライアント
    - 設定から「パフォーマンス」を検索、「パフォーマンスを優先」に変更
    - 設定→アクセシビリティ→視覚効果→すべてオフに
- [ ] 外部リモート



## WinGet
- 先に手動インストール？Wingetでいけそうならそっちへ
    - [Chrome](https://www.google.com/intl/ja_jp/chrome/)
    - [Google IME](https://www.google.co.jp/ime/)
    - [Explzh](https://www.ponsoftware.com/archiver/download.htm)
    - [LINE](https://apps.microsoft.com/store/detail/line/9WZDNCRFJ2G6)
    - [Quest Setup のアプリ](https://www.meta.com/jp/quest/setup/)
    - [Logi Options+](https://www.logicool.co.jp/ja-jp/software/logi-options-plus.html)
    - [Twinkle Tray](https://apps.microsoft.com/detail/twinkle-tray%3A-brightness-slider/9PLJWWSV01LK?hl=ja-JP&gl=US)
- Search: `winget search`
- Update: `winget upgrade --all`
- JSON Export: `winget export -o apps.json`
- JSON Import: `winget import -i apps.json --ignore-versions --accept-package-agreements --accept-source-agreements --ignore-unavailable`



## WSL、Develop
1. Terminalで`wsl --install`
1. 再起動
1. ユーザー・パスを設定 Windowsと一緒にしとく。(hirat/ログオンPass)
1. `sudo apt update`→`sudo apt upgrade -y`
1. .zshrc, .git_config, .git_ignore を**WSLの**ユーザーフォルダに置いとく
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
1. `sudo apt install zsh`
1. `which zsh` して、`chsh`の結果にそのパスを打つ→再起動
    - たぶん `chsh -s /usr/bin/zsh` になるはず
1. いちど `code .` するとCodeコマンドがインスコされる
1. VS CODEのターミナルが変わってなければ変更
1. https://github.com/psephopaiktes/dotfiles/blob/master/install.sh 参考に
1. Windows Terminal の設定からデフォルトシェルをWSLに
