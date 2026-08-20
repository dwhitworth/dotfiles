# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Standard plugins (add more here if you need them, like 'z' or 'syntax-highlighting')
plugins=(
    git
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# zsh-autosuggestions' async mode forks a background worker per keystroke and
# leaks a file descriptor pair on teardown (zsh-users/zsh-autosuggestions#815).
# Over a long session this exhausts the fd limit and corrupts zle input
# handling (double-typed keys, "bad file descriptor" errors). Force sync mode.
unset ZSH_AUTOSUGGEST_USE_ASYNC

# User configuration
export PATH="$HOME/.local/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Zoxide (Better cd) ---
eval "$(zoxide init zsh)"
alias cd="z"

# --- LSD (Better ls) ---
alias ls='lsd'
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'

# --- Aliases ---
command -v bat &>/dev/null && alias cat='bat'
alias bubu='brew update && brew upgrade'
alias bubuc='brew update && brew upgrade && brew cleanup'
# --- DYNAMIC NODE MANAGER LOADING ---

# 1. Check for Mise (Personal Machine)
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
  # Add this line to ensure sbt and other tools find the JVM
  export MISE_JAVA_HOME=1

# 2. Check for NVM (Work Machine)
elif [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# --- DNS & Networking Utils ---

# Flush DNS Cache (macOS)
alias dnsflush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder; echo '✅ DNS cache flushed.'"

# Set DNS to Cloudflare (1.1.1.1)
# Note: 'Wi-Fi' is the default interface name, change if you use Ethernet/USB-C
dnson() {
    local interface="Wi-Fi"
    sudo networksetup -setdnsservers "$interface" 1.1.1.1 1.0.0.1
    echo "✅ DNS set to Cloudflare (1.1.1.1) on $interface"
    dnsflush
}

# Reset DNS to Automatic (DHCP from ISP)
dnsoff() {
    local interface="Wi-Fi"
    sudo networksetup -setdnsservers "$interface" "Empty"
    echo "🔄 DNS reset to Automatic (ISP) on $interface"
    dnsflush
}

# Check current DNS settings
alias dnscheck="networksetup -getdnsservers Wi-Fi"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# --- Editor ---
export EDITOR='nvim'
export VISUAL='nvim'


# --- zsh-autocomplete (manual plugin: git clone into ~/.zsh/plugins) ---
[[ -f ~/.zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]] && \
  source ~/.zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# --- Machine-local overrides (work aliases, tokens, machine-specific PATHs) ---
# Not tracked in git (see .gitignore: *.local). Create ~/.zshrc.local per machine.
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local

# Pi
export PATH="/Users/donovanwhitworth/.local/share/mise/installs/node/24.19.0/bin:$PATH"
