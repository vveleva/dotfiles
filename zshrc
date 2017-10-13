source_file() { [[ -f $1 ]] && source $1 }

##### ZSH INSTALLATION #########################################################
# [[ -f ~/.zsh_setup ]] && source ~/.zsh_setup
source_file ~/.zsh_setup

##### CONFIGURE PATH ###########################################################
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

##### LOAD NVM #################################################################
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

PATH="/usr/local/heroku/bin:$PATH"
PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
PATH="$PATH:$HOME/.yarn/bin"
PATH="$HOME/enjoy/super_samurai/bin:$PATH"

export -U PATH

export MANPATH="/usr/local/man:$MANPATH"
export EDITOR="vim"
export SSH_KEY_PATH="~/.ssh/dsa_id"

##### CHANGE DIRECTORIES #######################################################
setopt AUTO_CD # type the name of a directory to cd to it
setopt CHASE_LINKS # resolve symbolic links when changing directory

##### HISTORY ##################################################################
setopt EXTENDED_HISTORY # save timestamps, use history -f to get date and time
setopt HIST_EXPIRE_DUPS_FIRST # oldest duplicates expire first
setopt HIST_FIND_NO_DUPS # dont find dups when reverse-searching history
setopt HIST_IGNORE_DUPS # do not save consecutive repeated commands
setopt HIST_NO_STORE # dont store the history command in history
setopt HIST_REDUCE_BLANKS # remove superfluous blanks from history
setopt SHARE_HISTORY # multiple shells retain the same history

HISTFILE=~/.history
HISTSIZE=999999999999999999
SAVEHIST=999999999999999999 # number of lines to save in HISTFILE

# Use vim as a manpager (instead of less)
export MANPAGER="col -bx | vim -MRc 'set ft=man fdm=indent nonu nornu' -"

export VISUAL="vim"
export EDITOR=$VISUAL

bindkey -v

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^R' history-incremental-search-backward
bindkey '^U' kill-whole-line
bindkey '^?' backward-delete-char

##### LOAD AUTOJUMP ############################################################
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

##### LOAD CUSTOM FUNCTIONS ####################################################
for function in ~/.zsh/functions/*; do
  source $function
done

##### SOURCE OTHER FILES #######################################################
source_file ~/.zsh_propmt
source_file ~/.aliases
source_file ~/.zshrc.local
