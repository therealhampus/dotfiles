# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/hampuse/repos/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Better history
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Bind TAB and Shift+TAB to select autocomplete menu AND cycle items.
bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select
bindkey -M menuselect              '^I'         menu-complete
bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

# Skim setup
setopt EXTENDED_HISTORY
setopt inc_append_history_time

# Bind
#
bindkey '^R' skim-history-widget

# Load aliases
for alias_file ("$HOME"/.zsh/aliases/*.zsh); do
  source "$alias_file"
done
unset alias_file

# Load exports
source $HOME/.zsh/exports

[[ -s "/Users/hampuse/.gvm/scripts/gvm" ]] && source "/Users/hampuse/.gvm/scripts/gvm"

# Go version manager
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hampuse/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hampuse/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hampuse/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hampuse/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Alias zoxide
alias cd="z"

eval "$(zoxide init zsh)"
