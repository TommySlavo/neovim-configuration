# Neovim configuration guidance

## Structure

- `init.lua` loads the core configuration, Lazy.nvim, and custom highlights.
- Plugin specifications live in `lua/tomslavonia/plugins/`; each file returns one Lazy.nvim spec.
- LSP and language-specific configuration live below `lua/tomslavonia/plugins/lsp/`.
- Keep keymaps with the feature that owns them when possible. Shared editor behavior belongs in `lua/tomslavonia/core/`.

## Change conventions

- Follow the surrounding Lua formatting and prefer small, focused plugin specs.
- Do not edit `lazy-lock.json` manually; update it only through an intentional Lazy.nvim sync.
- Preserve existing user changes and do not revert unrelated files.
- For AI assistance, use Codex for repository-aware work and keep inline completion limited to small local edits.

## Verification

- After Lua configuration changes, run `nvim --headless "+qa"`.
- For plugin changes, open Neovim and run `:Lazy sync` only when dependency installation or lockfile updates are intended.
