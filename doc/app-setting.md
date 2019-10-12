# Mac App Setting

## Primary
アプリ | 設定項目
--|--
Chrome | ログイン、DL先をデスクトップに
Google Backup and Sync | ログイン、Desktopのみバックアップ、同期するフォルダを指定
Google Drive Files Stream | ログイン、起動時に起動しない
Dropbox | 同期するフォルダを指定、保存先をSSDに指定、起動時にログインしない
Xcode | いちど起動して初期設定しておく
Visual Studio Code | パレットでShellって検索→インスコ. [SettingSync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)入れてログインを押し、[Gistを選択](https://github.com/settings/tokens)、`⌥⇧D`で設定落とす。
[Sourcetree](https://ja.atlassian.com/software/sourcetree) | AttrasianにGoogleログイン､<br>Advenced > 強制Pushを可能に<br>AccountsからGitHub追加>Defaultに
Docker | ログイン､Start Doker when you login:OFF、割当メモリを増やす
Abstract | ログイン
Creative Cloud | 言語を日本語にしてから各種インスコ､ログイン時に起動をオフ､ファイル同期をオフ
ImageOptim |  Optimization Lavel: Insane
Sketch |  下参照
Figma | ログイン<!-- 、[Fontsインスコ](https://www.figma.com/settings) -->
Google IME | Macシステム環境設定→キーボード→入力ソースからほぼ消す/[Macの入力ソースからUSを消す方法](https://nishi3.hatenablog.com/entry/2018/01/18/161745)<br>入力補助 -「、。」「・「」」「？！」など意外は全部半角入力に<br>一般-候補選択ショートカット-A--L<br>一般-キ-設定の選択-MSIME<br>辞書をインポート
Alfred | PowerPackからActivate→AdvancedからGoogleDriveを指定
LINE | Login, Chats > 送信方法⌘Enter
AppCleaner | スマートシンクをONに、protectをすべて外す
Better Touch Tool |  iCloudと同期、Launch BTT on startup､<br>Appearance of the preview window:Bg #000 20%, Border 0%, Radius 12px <!-- 初回起動設定後BST消す､設定をimport -->
アーカイブユーティリティ | プリイン。Dockに追加、`open /System/Library/CoreServices/Applications/` 保存場所:Desktop､展開後:ゴミ箱､アーカイブのフォーマット:Zip
IINA | Utility > Set IINA as the Default Application...<br>import keyconfig


### Adobe設定
- 設定の同期機能が消えたので最低限のみメモ
- Ps
 - ドキュメントを開いていないときにスタートワークスペースを表示 OFF
 - 単位をすべてpxに
 - プラグイン > Generatorを有効する ON
- Ai
 - 単位をすべてpxに 
 - キー入力を1pxに
 - サイズ行送り、ベースラインシフト 1px
 - ユーザーインターフェース 最大まで明るく
 - ドキュメントを開いていないときにスタートワークスペースを表示 OFF

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
[Stark](http://www.getstark.co/) | 色弱者向けの表示を確認できる
SVGO Compressor | 公式のSVG圧縮プラグイン
Find and Replace | テキスト置換
Browser Preview |
[Move-to-library-sketchplugin](https://github.com/ahmedmigo/Move-to-library-sketchplugin) | 
