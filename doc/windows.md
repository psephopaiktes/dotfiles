## TBD
- [ ] https://twitter.com/zmukkuri/status/1651151599853772802
- [ ] https://zenn.dev/lovegraph/articles/529fe37caa3f19?utm_source=pocket_saves
- [ ] https://www.ubackup.com/jp/windows-11/windows-11-random-restart.html
- [ ] [Windows 11のPCが勝手に再起動する場合の対処法6つ](https://www.ubackup.com/jp/windows-11/windows-11-random-restart.html)
- [ ] プライバシー系
    - [ ] Media Player 最近使ったファイル →消せなそうだから他のアプリかなあ VLC?
    - [ ] Dropbox やOther検索にヒットさせない
    - [ ] 漫画Viewer



## STEP
1. 日本語でスタート、MSサインイン、「以前のPCから設定を引き継ぐ」
2. 設定同期のためOne Driveに最初だけサインインしとく
3. ひたすらアップデート
4. Cleartypeで検索して設定
5. apps.json落として中身確認し、[WinGetでInstall↓](#WinGet)
6. Dropbox/Appフォルダはローカルに設定
7. Powertoys設定
    - 常に管理者として実行
    - Caps → Ctrl は Ctrl が押しっぱなし状態になってしまうバグがあるのでDropbox/App/CapToRightCtrl.regを実行する
        - もしくは[Change Key](https://forest.watch.impress.co.jp/library/software/changekey/)を使ってCtrl(Right)に変える
    - Dropbox/Appからバックアップを復元、その他ひととおり確認
8. [App Setting 参考](https://github.com/psephopaiktes/dotfiles/blob/master/doc/app-setting.md)
    1. Google IME の設定で「一般→キー設定の選択」でインポート. アプリを再起動するまでは反映されないので注意
    1. Logi Optionの設定、トラックパッドの設定など
9. コントロールパネル
    - 「ユーザーアカウント制御」を1段階下げる
10. デスクトップ右クリック→個人用設定→テーマ→ゴミ箱アイコンを非表示にする
11. トラックパッドの設定
    * ![image](https://github.com/psephopaiktes/dotfiles/assets/4294850/5a005926-ecbd-416e-9946-5f501e059528)
    * 3 Finger
        * タップ: マウスの中央ボタン
        * 上方向にスワイプ: `^⇧T`
        * 下方向にスワイプ: `^W`
        * 左方向にスワイプ: `^⇧⇥`
        * 右方向にスワイプ: `^⇥`
    * 4 Finger
        * タップ: マウスの戻るボタン
        * 上方向にスワイプ: `Win⇥`
        * 下方向にスワイプ: デスクトップの表示
        * 左方向にスワイプ: `Win^←`
        * 右方向にスワイプ: `Win^→`
13. エクスプローラのオプション
    - 全般 → 「最近使ったファイルを...」「よく使うフォルダを...」OFF
    - 表示 → タイトルバーに完全なパスを表示
    - 表示 → 隠しファイルの表示、拡張子の表示
14. プライバシーとセキュリティから検索除外するフォルダを設定
15. 設定→アプリ→スタートアップから選択
16. Start, Taskバーの整理
    * ![image](https://github.com/psephopaiktes/dotfiles/assets/4294850/0864bfc2-713d-4ce0-925e-a379e54520b3)
    * ![image](https://github.com/psephopaiktes/dotfiles/assets/4294850/02d9316c-7157-48be-8010-217bc905a60c)
17. その他
    * ナイトシフト
18. システム言語を英語に変更
19. [会社VPNの接続](https://wiki.unext-info.jp/pages/viewpage.action?pageId=71448379)



## シンクライアント運用
- ホスト
    - 設定のリモートから有効化する
    - Remote Desktop の場合、3本指タップが意図通りにならない場合もある。その場合はDropbox/AppのRegファイルを実行
- クライアント
    - 設定から「パフォーマンス」を検索、「パフォーマンスを優先」に変更
    - 設定→アクセシビリティ→視覚効果→すべてオフに
    - [SoftEther VPN プロジェクト - SoftEther VPN プロジェクト](https://www.softether-download.com/ja.aspx?product=softether)



## WinGet
- 先に手動インストール？Wingetでいけそうならそっちへ
    - [Chrome](https://www.google.com/intl/ja_jp/chrome/)
    - [Google IME](https://www.google.co.jp/ime/)
    - [LINE](https://apps.microsoft.com/store/detail/line/9WZDNCRFJ2G6)
    - [Quest Setup のアプリ](https://www.meta.com/jp/quest/setup/)
    - [Logi Options+](https://www.logicool.co.jp/ja-jp/software/logi-options-plus.html)
    - [Twinkle Tray](https://apps.microsoft.com/detail/twinkle-tray%3A-brightness-slider/9PLJWWSV01LK?hl=ja-JP&gl=US)
    - [MS PC Maneger](https://pcmanager.microsoft.com/)
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
