##### ZSH INSTALLATION #########################################################
[[ -f ~/.zsh_setup ]] && source ~/.zsh_setup

##### USER CONFIG ##############################################################
[[ -f ~/.zsh_user_config ]] && source ~/.zsh_user_config

##### REQUIRED BY RBENV ########################################################
export PATH="/usr/local/sbin:$PATH:${HOME}/bin"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export MANPATH="/usr/local/man:$MANPATH"
export EDITOR="vim"
export SSH_KEY_PATH="~/.ssh/dsa_id"

##### CHANGE DIRECTORIES #######################################################
setopt AUTO_CD # type the name of a directory to cd to it
setopt CHASE_LINKS # resolve symbolic links when changing directory

##### HISTORY ##################################################################
setopt SHARE_HISTORY # multiple shells retain the same history
setopt EXTENDED_HISTORY # save timestamps, use history -f to get date and time
setopt HIST_IGNORE_DUPS # do not save consecutive repeated commands
setopt HIST_FIND_NO_DUPS # dont find dups when reverse-searching history
setopt HIST_EXPIRE_DUPS_FIRST # oldest duplicates expire first
setopt HIST_NO_STORE # dont store the history command in history
setopt HIST_REDUCE_BLANKS # remove superfluous blanks from history

# NOTE: must have SAVEHIST <= HISTSIZE, for unspecified reasons
# http://zsh.sourceforge.net/Guide/zshguide02.html#l7
HISTSIZE=999999999999999999
SAVEHIST=999999999999999999 # number of lines to save in HISTFILE
HISTFILE=~/.history

##### LOAD AUTOJUMP ############################################################
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

##### Added by the Heroku Toolbelt #############################################
export PATH="/usr/local/heroku/bin:$PATH"

##### Enable autosuggestions automatically #####################################
# zle-line-init() {
#   zle autosuggest-start
# }
# zle -N zle-line-init

# Use vim as a manpager (instead of less)
export MANPAGER="col -bx | vim -MRc 'set ft=man fdm=indent nonu nornu' -"


#### SET PROMPT ################################################################
[[ -f ~/.zsh_prompt ]] && source ~/.zsh_prompt

##### ALIASES ##################################################################
[[ -f ~/.aliases ]] && source ~/.aliases

##### LOCAL CONFIG #############################################################
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

bindkey -v

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^R' history-incremental-search-backward
bindkey '^U' kill-whole-line

source ~/.samurai_db_env
bindkey '^?' backward-delete-char

# node version manager
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"
