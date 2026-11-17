# AI向け作業ルール

- `README.md` はリポジトリ所有者が読むためのファイルです。明示的に依頼されない限り編集しないでください。
- レビュー・整合性確認・実装の依頼は、`README.md` 自体の編集許可を含みません。ユーザーが `README.md` の編集を明示した場合だけ編集してください。
- 作業中に `README.md` の修正が必要だと判断した場合は、編集せずに必要な変更内容を示してユーザーへ確認してください。
- AI向けの運用メモは `README.md` ではなく、この `AGENTS.md` に記載してください。
- リポジトリ内のURL・ドメイン・個人用メモ・社内情報は、ファイルを問わずリポジトリ所有者が公開を許容しています。機密情報として削除・置換しません。新規の認証トークン・秘密鍵はこの許容に含みません。

## 実装方針

- 個人用の軽量なdotfilesとして、実際の利用に必要な最小限の実装を優先し、特殊なエッジケースのために複雑化しません。

## Mac初期設定の管理

- `.bin/.config/mise/` をセットアップ定義の正本とし、共通設定は `config.toml`、パッケージ・ツール・リポジトリ・dotfiles・macOS defaults・タスクは `conf.d/*.toml` に分けて管理します。
- 初期化と再適用には `mise bootstrap` を使用します。Homebrew Brewfileや独自のlink/install/defaultsスクリプトは作成しません。
- ユーザーから「最新版にして」などセットアップ全体の更新を依頼された場合は、作業ツリーを確認してから `mise bootstrap --update --upgrade --skip-dirty` を使用します。設定の再適用だけなら `--upgrade` を省き、確認だけなら `mise bootstrap --dry-run --skip-dirty` を使用します。
- `.bin/` の既存ファイルはシンボリックリンクへ即時反映されます。新規ファイルは `.bin/.config/mise/conf.d/30-repos-dotfiles.toml` の `[dotfiles]` に追加し、`mise dot apply` で反映します。
- 認証トークン・秘密鍵・ログ・キャッシュ・自動生成ファイル・`node_modules` は `.bin/` の管理対象に含めません。
- miseで宣言できない対話処理だけを `shell/bootstrap.sh` に記載します。
- 構文検査には `mise run check` を使用します。

## LLM共通指示の管理

- このルートの `AGENTS.md` はdotfilesリポジトリ内だけの作業ルールです。Mac全体で使うLLM共通指示とは分けて管理します。
- Mac全体のLLM共通指示は `.bin/AGENTS.md` を唯一の正本とします。内容を変更するときはこのファイルだけを編集してください。
- miseの`[dotfiles]`設定が初期化時に `.bin/AGENTS.md` へのシンボリックリンクを次の場所へ作成します。
  - `~/AGENTS.md`
  - `~/.codex/AGENTS.md`
  - `~/.claude/CLAUDE.md`
  - `~/.copilot/copilot-instructions.md`
- `.bin/.codex/AGENTS.md`、`.bin/.claude/CLAUDE.md`、`.bin/.copilot/copilot-instructions.md` は作成しません。
- LLM固有の設定ファイル、MCP設定、statuslineは引き続き各LLMのディレクトリで個別管理します。
- `.bin/.claude/settings.json` のFigma・Atlassian MCP全ツール許可は意図した設定です。セキュリティ上の問題として扱わず、ユーザーの明示的な依頼なしに制限・変更しません。

## Agent Skillsの管理

- 配布元はルートの `agent-skills.tsv` を正本とし、SKILL実体はリポジトリへ保存しません。
- `shell/sync-skills.sh` が公式配布元の最新版を `~/.local/agent-skills` へ取得します。
- Codex・Claude Codeにはルートごとではなく、各SKILLへのシンボリックリンクを作成します。
- 更新確認には `mise run skills:check`、更新には `mise run skills:update` を使用します。
- SkillsまたはAI設定を扱う作業では、`~/.cache/dotfiles/skills-last-check`が7日以上前なら、作業開始時に一度だけ`mise run skills:check`を実行してください。確認だけ行い、ユーザーの依頼なしに更新はしません。
- 常設対象は `agent-skills.tsv` に個別指定した19件です。リポジトリ単位の全件導入はしません。
- 基本7件は Modern Web Guidance、Remotion、OpenAI Security、Playwright、Android CLI、Cloudflare、Chrome DevToolsです。
- Figmaは公式16件のうち `figma-code-connect`、`figma-generate-diagram`、`figma-use-figjam`、`figma-use-slides` を除く12件を常設します。
- `playwright-cli` SKILLが使用するCLI本体は `.bin/.config/mise/conf.d/10-tools.toml` の `npm:@playwright/cli` で管理します。
- Chrome DevToolsのCLI本体はmise、MCP設定は各Agentの設定ファイルと `shell/bootstrap.sh` で管理します。
- Remotion本体はグローバルインストールせず、SKILLが `npx create-video@latest` でプロジェクトを作成する際にプロジェクト依存としてインストールします。

## Figmaの管理

- Figma公式SKILLも共通のSKILL保存先から共有し、Claude Codeから利用できるようにします。
- Codexの `.bin/.codex/config.toml` は初回配置用テンプレートです。ChatGPT/Codexが更新する実ファイル `~/.codex/config.toml` は上書きしません。個人設定の既定値を変えるときは両方を更新します。
- Claude CodeのユーザースコープMCPは `~/.claude.json` に保存されるため、`shell/bootstrap.sh` が `claude mcp add` で登録します。

## Pythonの管理

- Python本体は `.bin/.config/mise/conf.d/10-tools.toml` のmiseで管理し、`python = "latest"` で実行時点の最新安定版を利用します。
- uv本体はHomebrewで管理し、`UV_PYTHON_PREFERENCE = "only-system"` と `UV_PYTHON_SEARCH_PATH` によりuv独自またはHomebrew依存のPythonを使用せず、miseが選択したPythonだけを利用します。プロジェクトで別バージョンが必要な場合は、そのプロジェクトのmise設定で宣言します。
- dotfilesの初期設定またはPython・mise設定を扱う作業では、作業開始時にPythonの最新安定版を公式情報で確認し、miseの解決結果と一致することを確認してください。
- プレリリース版や特定バージョンへの固定は、ユーザーから明示的に依頼された場合だけ行ってください。
- HomebrewがFormulaの依存関係として導入するPythonは許可し、削除や禁止をしません。
