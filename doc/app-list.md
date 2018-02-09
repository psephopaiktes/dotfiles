# app-list
- 手動でインスコするアプリとその設定



## Primary
アプリ | 設定項目
--|--
[Chrome](https://www.google.co.jp/chrome/browser/desktop/index.html)  |  ログイン、DL先をデスクトップに
[Google Drive](https://www.google.com/drive/download/)  |  同期するフォルダを選択、USBデバイスとSDカードのチェック外す
[Dropbox](https://www.dropbox.com/h)  |   同期するフォルダを選択、 Not launch at login


## Dev
アプリ | 設定項目
--|--
[Visual Studio Code](https://code.visualstudio.com/) |  app-init.shで自動的に設定同期。ターミナルから呼び出せるようにするにはコマンドパレットShellからshellのインスコがいるかも?
[Dash](https://kapeli.com/dash) | ライセンスファイルをimport､設定ファイルをimport､Launch dash at login､show menubar icon
[iTerm2](https://www.iterm2.com/) | 設定ファイルをimport
[Sourcetree](https://ja.atlassian.com/software/sourcetree)  |  Attrasianログイン､GitHubログイン､SSH作成､強制Pushを可能に
[SonicWALL Mobile Connect](https://itunes.apple.com/jp/app/sonicwall-mobile-connect/id822514576)  |  VPN設定
[Opera](http://www.opera.com/ja)  |  
[Vivaldi](https://vivaldi.com/?lang=ja_JP)  |  
[Firefox](https://www.mozilla.org/ja/firefox/new/)  |  ログイン
[Docker](https://docs.docker.com/docker-for-mac/install/#download-docker-for-mac)  |  ログイン､Start Doker when you login:OFF
[Xcode](https://itunes.apple.com/us/app/xcode/id497799835)  |  
[Ricty Diminished](http://www.rs.tus.ac.jp/yyusa/ricty_diminished.html)  | 最新版を全ウェイトいれる


## Design
アプリ | 設定項目
--|--
[CLIP STUDIO](https://www.clip-studio.com/clip_site/rental/rental_download/sprental/)  |  起動初期設定､ログイン､PAINT起動→[アクティベート](https://www.clip-studio.com/clip_site/tool/manage/store)
[Creative Cloud](https://creative.adobe.com/ja/products/download/creative-cloud)  |  各種インスコ､ログイン時に起動をオフ､ファイル同期をオフ→フォルダを削除
[ImageOptim](https://imageoptim.com/mac)  |  最適化の速度:非常に高い
[Origami Studio](https://origami.design/)  |  
[Zeplin](https://zeplin.io/) |  ログイン
[Sketch](https://www.sketchapp.com/) |  下参照
[FontBase](https://fontba.se/) | GoogleDriveのフォントを読み込んでおく
[Skitch](https://evernote.com/intl/jp/products/skitch) | 
[xScope](https://xscopeapp.com/) | activate
[SPAi](http://tama-san.com/spai/) | 

### CC
- 設定の同期機能が消えたので最低限のみメモ
- Ps
  - ドキュメントを開いていないときにスタートワークスペースを表示 OFF
  - 単位をすべてpxに
  - Generatorを有効する ON
- Ai
  - 単位をすべてpxに 
  - キー入力を1pxに
  - サイズ行送り、ベースラインシフト 1px
  - ユーザーインターフェース 最大まで明るく
  - ドキュメントを開いていないときにスタートワークスペースを表示 OFF
- Acrobat
  - Sign in

### Sketch
- 設定
  - Sketch > Preferences > Layers タブの Duplicating > Rename duplicated layers のチェックを外す。
  - Sketch > Preferences > Layers タブの Flatten Bitmap を2xに
  - Sketch Cloud にサインイン
- Plugins
  - [Sketch Runner](http://sketchrunner.com/)
  - [Craft by InVision](https://www.invisionapp.com/craft)
  - [Midnight](https://midnightsketch.com) : 黒いテーマに変えれる。挙動微妙
  - Zepling : アプリ入れたら自動で入る
#### Runnerから手動インスコ
Plugin | Note
-|-
[Chain](https://lalomrtnz.github.io/Chain/) | 色の一括変換
Pixel Perfecter | 座標に小数点が含まれているオブジェクトを探してくれる
Rename It | レイヤーをまとめて
Select Similar Layers | AIのように、共通のレイヤーを選択できる
[Symbol Organizer](https://github.com/sonburn/symbol-organizer) | シンボル整理
[Stark](http://www.getstark.co/) | 色弱者向けの表示を確認できる
SVGO Compressor | 公式のSVG圧縮プラグイン
Find and Replace | テキスト置換

#### ACV
Plugin | Note
-|-
ANIMATEMATE | Sketch上でアニメーションを作成できるようにする
Align Text Baseline | 文字のベースラインを揃える。特に日本語用
Align To | Aiのようにキーオブジェクトを選択して揃える
[artboard-manager](https://github.com/bomberstudios/artboard-manager) | 作成したアートボードを縦横カラムに合わせて再配置してくれるプラグイン
[Auto Rayout](https://storify.com/yhassy/sketch-app-dede) | 配置を自動でいい感じに
[Automate](http://ashung.github.io/Automate-Sketch/)  |  「あるといいなー」と思っていた細かい操作がたくさんできるようになるプラグイン。オブジェクトの Y 軸に合わせてレイヤーを並べ替え。選択中のレイヤーの子要素をすべて選択。フォントの入れ替え。使っていないスタイルの削除。グループからアートボード作成 … などなど数十種類の操作が入っています。Runnerとの相性が良い。
[Blender](https://github.com/bunnieabc/Blender) | イラレのブレンドツール的なことができる
Cottent Sync (PLuginではない) | SKetch中のテキスト情報をGoogleスプレッドシートで管理できるソフト
[Cleanup-Useless-Groups](https://github.com/bomberstudios/Cleanup-Useless-Groups) | 空のレイヤーフォルダを削除
[Confetti](http://www.sketchconfetti.com/), [IconFlower](https://github.com/avadhbsd/IconFlower), [Skatter](https://github.com/joshdjuric/Skatter) | 好きなアイコンを使って、継ぎ目のないパターンテクスチャ素材を作成
Content Generator | Craftでいいかも
CSSKetch | SketchのCSSエクスポート
Font Finder | 使われているフォントを一覧化し、指定したフォントを選択
Looper | Photshopのアクションの用に、特定の作業を繰り返すバッチ処理ができる http://sureskumar.com/looper/
[Magic Mirror 3](http://magicsketch.io/mirror/) | Sketchで作成したどんなファイルも破壊することなく、立体的な見た目で表現できるプラグイン。
Sketch Palettes | パレットを保存、読み込みできる
Sort Lauyers | レイヤーをソート 別でインスコ…?
[sort-me-sketch](https://github.com/romashamin/sort-me-sketch) | レイヤーソート
States | Sketchの様々な配置状態を記録・呼び出しできる。ホバーアニメーションとかの表現に
Swatches | GMDとかのカラーパレットを呼び出せる
[Sync to Slides](https://websiddu.github.io/sync-to-slides/) | Googleスライドと同期できる
User Flows | 簡単に画面遷移フローチャートを書き込める
Git | Sketch上からGIt操作できる。加えて、diff用のプレビュ画像を作成できる



## Other
アプリ | 設定項目
--|--
[Google IME](https://www.google.co.jp/ime/)  |  Macシステム環境設定→キーボード→入力ソースからほぼ消す<br>入力補助 -「、。」「・「」」など意外は全部半角入力に<br>一般-候補選択ショートカット-A--L<br>一般-キ-設定の選択-MSIME<br>辞書をインポート
[Alfred](https://www.alfredapp.com/) | PoerPackからActivate→Advancedからimport
[Project IINA](https://lhc70000.github.io/iina/)  |  WIP
[LINE](https://itunes.apple.com/jp/app/line/id539883307) | 送信方法⌘ENter
[Fluid Browser](https://itunes.apple.com/us/app/fluid-browser/id1077036385) |  なし
[AppCleaner](https://freemacsoft.net/appcleaner/)  |  スマートシンクをONに、protectをすべて外す
[Skype](https://www.skype.com/ja/get-skype/)  |  なし
[StuffIt Expander 16](https://itunes.apple.com/jp/app/stuffit-expander-16/id919269455)  |  Expand archives to 「Same..」､Move archives trash: On､保存場所:デスクトップ
[EdgeView 2](https://itunes.apple.com/jp/app/edgeview-2/id1206246482)  |  WIP
[Better Touch Tool](https://www.boastr.net/downloads/)  |  [BST](https://itunes.apple.com/jp/app/bettersnaptool/id417375580)をインスコ、初回起動設定後BST消す､ジェスチャをimport､Launch BTT on startup､Enabale automatic update checking､<br>APeearance of the preview window:Bg #000 20%, Border 0%, 
[Kindle](https://itunes.apple.com/jp/app/kindle/id405399194?mt=12)  |  
アーカイブユーティリティ ｜　プリイン。保存場所:Desktop､展開後:ゴミ箱､アーカイブのフォーマット:Zip､

## ACV
アプリ | 設定項目
--|--
[MacZip4Win](http://ynomura.com/home/?page_id=116)  |  
[HandBrake](https://handbrake.fr/)  |   
[Sketchpacks](https://sketchpacks.com/)  |  
[NameChanger](https://mrrsoftware.com/namechanger/)  |  
