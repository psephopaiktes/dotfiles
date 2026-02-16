- [ ] [【保存版】Windows 11の「あの設定はどこ？」問題を解決。一瞬で設定画面を開く「ms-settings」活用バイブル：Tech TIPS - ＠IT](https://atmarkit.itmedia.co.jp/ait/articles/2512/24/news016.html)
- [ ] [SageThumbs download | SourceForge.net](https://sourceforge.net/projects/sagethumbs/)
- [ ] OneDriveの配下にDesktopやDownloadが置かれかねない。いちどそうなるとけっこうめんどい。最初からいっさい使わないで速攻アンインストールがいいかなあ。
- [ ] フォルダ名がかなり厄介なので、絶対に英語で初期化!!!!


## ※低スペックPCの場合
以下だけ意識しとく
- 設定→ゲーム から以下を開いてOFFICE
    - →Xbox Game Bar
    - →ゲームモード
- 「透明効果」をオフ
- システムの詳細設定→詳細設定→パフォーマンスで「パフォーマンスを優先」に。ただし
`スクリーンフォントの縁を滑らかにする`はONにしておく。
    - Cleartypeは設定不要かな。
    - デスクトップ移動のアニメーション効果は欲しい、てか無いとわからん

## STEP
0. 日本語でスタート、MSサインイン、「以前のPCから設定を引き継ぐ」
    0. 設定同期のためOne Driveに最初だけサインインしとく
    0. ひたすらOSアップデート
0. ナイトシフトを設定
0. 設定→システム→開発者向け を各種設定
0. 設定→システム→通知→最下部の`追加の設定`→`Windowsを最大限に活用し・・・`をオフ
0. Cleartypeで検索して設定
0. apps.json落として中身確認し、[WinGetでInstall↓](#WinGet)
0. [App Setting 参考](https://github.com/psephopaiktes/dotfiles/blob/master/doc/app-setting.md)
    0. Google IME の設定で「一般→キー設定の選択」で辞書やキーマップをインポート。アプリを再起動するまでは反映されないので注意
    0. Logi Optionの設定、トラックパッドの設定など。ログインで同期できるっけ?
0. Dropbox/Appフォルダはオフラインアクセスに設定
0. `規定の入力方式の上書き` をGoogle IMEに
0. Powertoys設定
    - 常に管理者として実行
    - US配列では Ctrl + ` が送信できないので[レジストリをいじる](https://zenn.dev/hkiku482/articles/0ab2ca2cfb287c)
    - Caps → Ctrl は Ctrl が押しっぱなし状態になってしまうバグがあるのでDropbox/App/CapToRightCtrl.regを実行する
        - もしくは[Change Key](https://forest.watch.impress.co.jp/library/software/changekey/)を使ってCtrl(Right)に変える
    - Dropbox/Appからバックアップを復元(Renameが必要かも?)、その他ひととおり確認
0. コントロールパネル
    - 「ユーザーアカウント制御」を1段階下げる
0. デスクトップ右クリック→個人用設定→テーマ→ゴミ箱アイコンを非表示にする
0. トラックパッドの設定
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
0. エクスプローラのオプション
    - 全般 → 「最近使ったファイルを...」「よく使うフォルダを...」OFF
    - 表示 → タイトルバーに完全なパスを表示
    - 表示 → 隠しファイルの表示、拡張子の表示
0. プライバシーとセキュリティからDropboxなど検索除外するフォルダを設定
    - Media Player, BandiView, 最近使ったファイルを表示させない
0. アプリ→インストールされているアプリから不要なものを削除。詳細オプションで『このアプリをバックグラウンドで実行する』を『常にオフ』に。
0. 設定→アプリ→スタートアップから選択
0. システムの詳細設定→詳細設定→起動と回復の設定で`自動的に再起動`をオフ
0. Start, Taskバーの整理
    * ![image](https://github.com/psephopaiktes/dotfiles/assets/4294850/0864bfc2-713d-4ce0-925e-a379e54520b3)
    * ![image](https://github.com/psephopaiktes/dotfiles/assets/4294850/02d9316c-7157-48be-8010-217bc905a60c)
0. システム言語を英語に変更
0. 必要なら[会社VPNの接続](https://wiki.unext-info.jp/pages/viewpage.action?pageId=71448379)
0. OneDriveを切る
0. デスクトップの場合、モニターがスリープからの復帰に反応しない場合もあるので設定
    - デバイスマネージャー → ユニバーサル シリアル バス コントローラー
    - `汎用USBコントローラー` の項目 (もしくはモニターに接続しているUSBケーブルを抜き取り後に消えた項目)を見つけて開く
    - 「電源の管理」を選択して「電力の節約のために、コンピューターでこのデバイスの電源をオフにできるようにする」のチェックを外す
    - すべての`USBルートハブ`という項目についても同様に



## WinGet
- 先に手動インストール？Wingetでいけそうならそっちへ
    - [Chrome](https://www.google.com/intl/ja_jp/chrome/)
    - [Google IME](https://www.google.co.jp/ime/)
    - [LINE](https://apps.microsoft.com/store/detail/line/9WZDNCRFJ2G6)
    - [Quest Setup のアプリ](https://www.meta.com/jp/quest/setup/)
    - [Logi Options+](https://www.logicool.co.jp/ja-jp/software/logi-options-plus.html)
    - [Twinkle Tray](https://apps.microsoft.com/detail/twinkle-tray%3A-brightness-slider/9PLJWWSV01LK?hl=ja-JP&gl=US)
    - [MS PC Maneger](https://pcmanager.microsoft.com/)
- Search: `winget search {query}`
- Update: `winget upgrade --all`
- JSON Export: `winget export -o apps.json`
- JSON Import: `winget import -i apps.json --ignore-versions --accept-package-agreements --accept-source-agreements --ignore-unavailable`
- PowerShell(Wndows PowerShellとは別)をTerminalの規定のシェルにしたい
    - 手動でパス追加しなきゃだめかも
    - `C:\Users\hirat\AppData\Local\Microsoft\WinGet\Links\pwsh.exe` とか



## シンクライアント運用
- ホスト
    - 設定のリモートから有効化する
    - Remote Desktop の場合、3本指タップが意図通りにならない場合もある。その場合はDropbox/AppのRegファイルを実行
- クライアント
    - 設定から「パフォーマンス」を検索、「パフォーマンスを優先」に変更
    - 設定→アクセシビリティ→視覚効果→すべてオフに
    - [SoftEther VPN プロジェクト - SoftEther VPN プロジェクト](https://www.softether-download.com/ja.aspx?product=softether)



<!--

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
1. https://github.com/psephopaiktes/dotfiles/blob/master/shell/install.sh 参考に
1. Windows Terminal の設定からデフォルトシェルをWSLに

-->
