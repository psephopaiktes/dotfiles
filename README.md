# dotfiles

[@psephopaiktes](https://github.com/psephopaiktes/) のMac初期設定用


<br /><br />


## 既存の端末を初期化する場合 (任意)

### 事前準備
1. ローカル設定のバックアップ
    - `~/projects`配下のローカルリポジトリ群は変更をPushしておく。DesktopやDownloadフォルダのバックアップ。
    - RaycastでExportコマンドの実施
1. Music.app からサインアウト
    - メニューの`Account`からサインアウト
1. Message.app からサインアウト
    - メニューの`Messages`>`Preferences`の`iMessage`タブからサインアウト
1. iCloud からサインアウト
    - `` >`System Preference` > 自分のApple IDを選択
    - `iCloud`で`Find My`を無効化
    - 最下部からサインアウト
1. ペアリングした Bluetooth デバイスをすべて削除

### 初期化

[Macを消去して工場出荷時の初期設定にリセットする - Apple サポート (日本)](https://support.apple.com/ja-jp/102664)

※ OSに対応した最新の情報を確認する
※ 初期設定時は**いったん英語ですすめる**ことを推奨


<br /><br />


## 初期設定手順

**適宜再起動推奨**


1. Gitを使えるようにするために Command Line Tools をインストールして同意
    ```zsh
    xcode-select --install
    ```

1. `mas`で必要になるため、App Storeへサインインしておく

1. 以下のコマンドを実行。途中でGitHub認証やパスワード入力を求められる。
    ```zsh
    (
      set -e
      init_script="$(mktemp "${TMPDIR:-/tmp}/dotfiles-init.XXXXXX")"
      trap 'rm -f "$init_script"' EXIT
      curl -fsSL https://raw.githubusercontent.com/psephopaiktes/dotfiles/main/init.sh -o "$init_script"
      zsh "$init_script"
    )
    ```
    `mise bootstrap` により以下が自動実行されます。
    - miseのインストール
    - このリポジトリのCloneとmiseグローバル設定への接続
    - CLI・アプリ・Mac App Storeアプリのインストール
    - dotfilesのシンボリックリンク作成
    - Node.js・Python・各種Agent CLIのインストール
    - Gitリポジトリ、macOS defaults、Agent Skills、MCPの設定

1. [Macのシステム環境設定](./doc/mac-setting.md)を行う

1. [アプリ設定](./doc/app-setting.md)を行う

1. miseで管理していないものをインストール
    - [Material Icon Font](https://fonts.google.com/download?icon.set=Material+Icons) ※自動導入分だけではフォントが足りない


<br /><br />


## セットアップを更新・再実行する

```zsh
mise bootstrap --update
```

変更内容だけ確認する場合は `mise bootstrap --dry-run` を使用します。


<br /><br />


## `.bin/` を更新した時

既存ファイルの変更はシンボリックリンクへ即時反映されます。新規ファイルは `.bin/.config/mise/config.toml` の `[dotfiles]` に対象を追加してから反映します。

```zsh
git add .bin/<path>
mise dot apply
```

`.bin/.codex/config.toml` は初回配置用テンプレートです。既存の `~/.codex/config.toml` は上書きしないため、個人設定の既定値を変える場合は両方を更新します。


<br /><br />


## `~/.config/` の設定を管理する

`~/.config/<app>/` 配下の設定ファイルも `.bin/.config/` に置けば同様に管理できます。実ファイルを移動し、`.bin/.config/mise/config.toml` の `[dotfiles]` に次のような設定を追加してからmiseで反映します。

```toml
"~/.config/<app>/<file>" = { mode = "symlink" }
```

```zsh
mkdir -p ~/projects/dotfiles/.bin/.config/<app>
mv ~/.config/<app>/<file> ~/projects/dotfiles/.bin/.config/<app>/<file>
git -C ~/projects/dotfiles add .bin/.config/<app>/<file>
mise dot apply
```

※ 認証トークンや秘密鍵などの機密ファイル（例: `gh/hosts.yml`）、ログ・キャッシュ・自動生成ファイル・`node_modules` は**管理対象に含めない**。`.bin/` 配下は Git にコミットされ公開される。


<br /><br />


## 検査

```zsh
mise run check
```
