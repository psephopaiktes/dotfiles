# Mac App Setting

## Primary
アプリ | 設定項目
--|--
Chrome | ログインx3 + td192w, chrome-stylize を反映
Google Drive | ログイン、一部をオフライン許可
Google IME | 入力補助 -「、。」「・「」」「？！」など意外は全部半角入力に<br>Space Input Width:Half<br>一般-候補選択ショートカット-A--L<br>一般-キ-設定の選択-MSIME<br>辞書をインポート
Xcode | いちど起動して初期設定しておく
Visual Studio Code | GitHubでログインして同期
Sourcetree | AttrasianにGoogleログイン､<br>Advenced > 強制Pushを可能に<br>AccountsからGitHub追加>Defaultに
Abstract | ログイン
Creative Cloud | 各種インスコ､ログイン時に起動をオフ､ファイル同期をオフ
ImageOptim | Optimization Lavel: Insane
Sketch |  下参照
Figma | ログイン、[Fontsインスコ](https://www.figma.com/settings)
Alfred | PowerPackからActivate→AdvancedからGoogleDriveを指定, Advanced→Force Keyboard: ABC
LINE | Login, Chats > 送信方法⌘Enter
AppCleaner | スマートシンクをONに、protectをすべて外す
Better Touch Tool |  iCloudと同期、Launch BTT on startup､<br>Appearance of the preview window:Bg #000 20%, Border 0%, Radius 12px
アーカイブユーティリティ | 起動して設定 展開後:ゴミ箱
IINA | Utility > Set IINA as the Default Application...<br>import keyconfig
forklift3 | default terminal 変更、Hide Mini、https://binarynights.com/manual#fileviewer

### ghコマンドの設定
1. `$ gh auth login` -> ブラウザにコード入れてログインし、プロトコルにSSHを選択
1. `$ gh config set editor "code --wait"` でエディタをVS CODEに設定

### Adobe設定
- System Preferences > Extensions > Core Sync を無効にしておく
- System Preferences > Language & Region > Apps から日本語にできる？
- CC Manager を自動起動しない設定にする

### Sketch 設定
- 設定
 - Sketch > Preferences > Layers タブの Duplicating > Rename duplicated layers のチェックを外す。
 - Sketch > Preferences > Layers タブの Flatten Bitmap を2xに
  - Register, Sketch Cloud にサインイン
- [Sketch Runner](http://sketchrunner.com/)
 - Login, Force Keyboard Local, `⌘/`でRUN
#### Runnerから手動インスコ
Plugin | Note
-|-
[Automate](http://ashung.github.io/Automate-Sketch/) | 「あるといいなー」と思っていた細かい操作がたくさんできるようになるプラグイン。オブジェクトの Y 軸に合わせてレイヤーを並べ替え。選択中のレイヤーの子要素をすべて選択。フォントの入れ替え。使っていないスタイルの削除。グループからアートボード作成 … などなど数十種類の操作が入っています。Runnerとの相性が良い。
Browser Preview |
[Chain](https://lalomrtnz.github.io/Chain/) | 色の一括変換
Pixel Perfecter | 座標に小数点が含まれているオブジェクトを探してくれる
Rename It | レイヤーをまとめて
Select Similar Layers | AIのように、共通のレイヤーを選択できる
[Symbol Organizer](https://github.com/sonburn/symbol-organizer) | シンボル整理
symbol instance locator | シンボルからすべてのインスタンスを探す
[symbol-instance-renamer](https://github.com/sonburn/symbol-instance-renamer)
Symbol Swapper | リンク切れのシンボルなどをリリンクできる
[Stark](http://www.getstark.co/) | 色弱者向けの表示を確認できる
SVGO Compressor | 公式のSVG圧縮プラグイン
Find and Replace | テキスト置換
Browser Preview |
[Move-to-library-sketchplugin](https://github.com/ahmedmigo/Move-to-library-sketchplugin) | 


全て終わったら
- System Preference >  Security & Privacy > Accessibility, Full Disk Access などを許可
- System Preference >  Users & Groups > Login Items を整理
- https://github.com/psephopaiktes/remo-portal
