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

1. Homebrew mas で必要になるので、App Storeはサインインしとく

1. 以下のコマンドを実行。定期的にパスワード入力を求められる。かなり時間はかかるので、後述の手動設定を並行してやるのを推奨。
    ```zsh
    (
      set -e
      init_script="$(mktemp "${TMPDIR:-/tmp}/dotfiles-init.XXXXXX")"
      trap 'rm -f "$init_script"' EXIT
      curl -fsSL https://raw.githubusercontent.com/psephopaiktes/dotfiles/main/init.sh -o "$init_script"
      zsh "$init_script"
    )
    ```
    以下が自動実行されます
    - このリポジトリをCloneする（既にある場合はpull）
    - そのまま `make all` でシェルスクリプトを実行する

1. [Macのシステム環境設定](./doc/mac-setting.md)を行う

1. [アプリ設定](./doc/app-setting.md)を行う

1. Homebrewで扱えないアプリをインストール
    - [Material Icon Font](https://fonts.google.com/download?icon.set=Material+Icons) ※Brewだけだとフォントが足りない


<br /><br />


## `.bin/` を更新した時

新規ファイル追加や更新したら、次を実行してシンボリックリンクを更新
```zsh
zsh ~/projects/dotfiles/shell/link.sh
```

※ `.bin/.codex/config.toml` は初回配置用テンプレートです。ChatGPT/Codexが更新する既存の `~/.codex/config.toml` は上書きしないため、個人設定の既定値を変える場合は両方を更新します。


<br /><br />


## `~/.config/` の設定を管理する

`~/.config/<app>/` 配下の設定ファイルも `.bin/.config/` に置けば同様に管理できる。実ファイルを移動してから `link.sh` を実行する（ファイル単位でシンボリックリンクされる）。

```zsh
mkdir -p ~/projects/dotfiles/.bin/.config/<app>
mv ~/.config/<app>/<file> ~/projects/dotfiles/.bin/.config/<app>/<file>
zsh ~/projects/dotfiles/shell/link.sh
```

※ 認証トークンや秘密鍵などの機密ファイル（例: `gh/hosts.yml`）、ログ・キャッシュ・自動生成ファイル・`node_modules` は**管理対象に含めない**。`.bin/` 配下は Git にコミットされ公開される。
