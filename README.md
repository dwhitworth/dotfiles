# dotfiles

Personal macOS configuration, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Shared across machines (personal + work). One repo, symlinked into `$HOME`.

## Layout

Each top-level directory is a **stow package** whose tree mirrors `$HOME`:

```
zsh/        → ~/.zshrc, ~/.zprofile, ~/.p10k.zsh
git/        → ~/.gitignore_global
tmux/       → ~/.tmux.conf, ~/.tmux.conf.local
nvim/       → ~/.config/nvim/          (LazyVim)
ghostty/    → ~/.config/ghostty/
raycast-scripts/  raycast config exports + scripts (not stowed)
```

Packages are installed per-machine (no shared Brewfile — the work and personal
machines intentionally differ). Use `brew leaves` to see what's explicitly installed.

## Setup on a new machine

```bash
brew install stow                       # if not already present
git clone git@github.com:dwhitworth/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Stow the packages you want (per-package):
stow zsh git tmux nvim ghostty
```

Stow refuses to overwrite existing real files — move or delete conflicting
`~/.zshrc` etc. first (back them up). `stow -D <pkg>` unlinks a package.

## Machine-specific & sensitive config

The committed `zsh/.zshrc` is machine-agnostic (uses `$HOME`, detects mise vs
nvm). Anything machine-specific or sensitive — work aliases, tokens, per-machine
PATHs — goes in **`~/.zshrc.local`**, which is gitignored (`*.local`) and sourced
at the end of `.zshrc`. Never commit tokens or vault paths to this repo (it's public).

## Node / language versions

`.zshrc` loads whichever version manager is present:

- **mise** (preferred) if installed — polyglot, also handles Python/JVM/etc.
- **nvm** as a fallback.
