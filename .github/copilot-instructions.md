# Copilot Instructions (dotfiles)

## Project scope
- This repo is macOS dotfiles for shell, terminal, window manager, and editor setups.
- Most files are meant to be symlinked into $HOME (often via GNU Stow).

## Conventions
- Prefer editing the repo files, not files in $HOME.
- Layout is GNU Stow: each top-level dir is a package whose tree mirrors $HOME
  (e.g. `nvim/.config/nvim` → `~/.config/nvim`, `zsh/.zshrc` → `~/.zshrc`).
- Machine-specific or sensitive shell config goes in `~/.zshrc.local` (gitignored
  via `*.local`), sourced at the end of `zsh/.zshrc`. Never commit tokens/paths.
- Do not edit the bundled tmux base config; customize via `tmux/.tmux.conf.local`.
- Keep config changes minimal and consistent with existing style (mostly simple, explicit settings).
- Use ASCII unless a file already uses non-ASCII characters.

## Key locations
- Shell: `zsh/.zshrc`, `zsh/.p10k.zsh`.
- Git: `git/.gitignore_global`.
- Tmux: `tmux/.tmux.conf` (base, avoid edits), `tmux/.tmux.conf.local` (overrides).
- Neovim: `nvim/.config/nvim` (LazyVim-based, see `init.lua`, `lua/`).
- Window manager: `aerospace/.config/aerospace/aerospace.toml`.
- Status bar: `sketchybar/.config/sketchybar`.
- Terminal: `ghostty/.config/ghostty/config`.
- Borders: `borders/.config/borders/bordersrc`.
- Packages: `Brewfile`.

## Editing guidance
- Keep shell scripts POSIX-ish unless file explicitly uses bash or zsh features.
- For tmux: add or tweak settings in `.tmux.conf.local` only.
- For Neovim: prefer new config in `nvim/.config/nvim/lua/` rather than editing `init.lua` directly.
- For Sketchybar/AeroSpace: preserve event names and hooks; they are wired together.
- For Brewfile: keep taps/casks/brews grouped and sorted as already present.

## Safe defaults for new additions
- Add concise comments only when a change is non-obvious.
- Avoid introducing new dependencies unless needed; add to `Brewfile` if required.
