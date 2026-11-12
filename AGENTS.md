# AI向け作業ルール

- `README.md` はリポジトリ所有者が読むためのファイルです。明示的に依頼されない限り編集しないでください。
- AI向けの運用メモは `README.md` ではなく、この `AGENTS.md` に記載してください。

## 実装方針

- 個人用の軽量なdotfilesとして、実際の利用に必要な最小限の実装を優先し、特殊なエッジケースのために複雑化しません。

## LLM共通指示の管理

- このルートの `AGENTS.md` はdotfilesリポジトリ内だけの作業ルールです。Mac全体で使うLLM共通指示とは分けて管理します。
- Mac全体のLLM共通指示は `.bin/AGENTS.md` を唯一の正本とします。内容を変更するときはこのファイルだけを編集してください。
- `shell/link.sh` が初期化時に `.bin/AGENTS.md` へのシンボリックリンクを次の場所へ作成します。
  - `~/AGENTS.md`
  - `~/.codex/AGENTS.md`
  - `~/.claude/CLAUDE.md`
  - `~/.copilot/copilot-instructions.md`
  - `~/.gemini/AGENTS.md`
- `.bin/.codex/AGENTS.md`、`.bin/.claude/CLAUDE.md`、`.bin/.copilot/copilot-instructions.md`、`.bin/.gemini/AGENTS.md` は作成しません。
- LLM固有の設定ファイル、MCP設定、statuslineは引き続き各LLMのディレクトリで個別管理します。

## Agent Skillsの管理

- 配布元はルートの `agent-skills.tsv` を正本とし、SKILL実体はリポジトリへ保存しません。
- `shell/sync-skills.sh` が公式配布元の最新版を `~/.local/agent-skills` へ取得します。
- Codex・Claude Code・Gemini CLIにはルートごとではなく、各SKILLへのシンボリックリンクを作成します。
- 更新確認には `make skills-check`、更新には `make skills-update` を使用します。
- SkillsまたはAI設定を扱う作業では、`~/.cache/dotfiles/skills-last-check`が7日以上前なら、作業開始時に一度だけ`make skills-check`を実行してください。確認だけ行い、ユーザーの依頼なしに更新はしません。
- 常設対象は `agent-skills.tsv` に個別指定した19件です。リポジトリ単位の全件導入はしません。
- 基本7件は Modern Web Guidance、Remotion、OpenAI Security、Playwright、Android CLI、Cloudflare、Chrome DevToolsです。
- Figmaは公式16件のうち `figma-code-connect`、`figma-generate-diagram`、`figma-use-figjam`、`figma-use-slides` を除く12件を常設します。
- `playwright-cli` SKILLが使用するCLI本体は `.bin/.config/mise/config.toml` の `npm:@playwright/cli` で管理します。
- Chrome DevToolsのCLI本体はmise、MCP設定は各Agentの設定ファイルと `shell/install.sh` で管理します。
- Remotion本体はグローバルインストールせず、SKILLが `npx create-video@latest` でプロジェクトを作成する際にプロジェクト依存としてインストールします。

## Figmaの管理

- Figma公式SKILLも共通のSKILL保存先から共有し、Claude Code・Gemini CLIから利用できるようにします。
- Codexの `.bin/.codex/config.toml` は初回配置用テンプレートです。ChatGPT/Codexが更新する実ファイル `~/.codex/config.toml` は上書きしません。個人設定の既定値を変えるときは両方を更新します。
- Gemini CLIは `.bin/.gemini/settings.json` で管理します。
- Claude CodeのユーザースコープMCPは `~/.claude.json` に保存されるため、`shell/install.sh` が `claude mcp add` で初回登録します。

## Pythonの管理

- Python本体は `.bin/.config/mise/config.toml` のmiseで管理し、uvはmiseが選択したPythonを利用します。
- dotfilesの初期設定またはPython・mise設定を扱う作業では、作業開始時にPythonの最新安定版を公式情報で確認してください。
- 設定中のマイナーバージョンより新しい安定版がある場合は、互換性への影響と変更内容を報告し、更新を提案してください。ユーザーの依頼なしに設定変更やインストールは行いません。
- HomebrewがFormulaの依存関係として導入するPythonは許可し、削除や禁止をしません。
