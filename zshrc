source_file() { [[ -f $1 ]] && source $1 }

autoload bashcompinit
bashcompinit

##### ZSH INSTALLATION #########################################################
autoload -Uz compinit && compinit
export ZSH=$HOME/.zsh

##### AUTOLOAD ZSH FUNCTIONS ###################################################
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

#### ZSH THEME #################################################################
setopt PROMPT_SUBST # Allow for functions in the prompt.
source "$ZSH/themes/velina.zsh-theme"

for plugin in $ZSH/plugins/*.plugin.zsh; do
  source $plugin
done

##### LOAD NVM #################################################################
export NVM_DIR="$HOME/.nvm"
# source "$(brew --prefix nvm)/nvm.sh"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

##### SETUP RBENV PATH #########################################################
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

##### SETUP PATH ###############################################################
PATH="/usr/local/heroku/bin:$PATH"
PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
PATH="$PATH:$HOME/.yarn/bin"
PATH="$HOME/voy/api/bin:$PATH"
PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"

export -U PATH
export MANPATH="/usr/local/man:$MANPATH"
export SSH_KEY_PATH="~/.ssh/dsa_id"

##### CHANGE DIRECTORIES #######################################################
setopt AUTO_CD # type the name of a directory to cd to it
setopt CHASE_LINKS # resolve symbolic links when changing directory

##### HISTORY ##################################################################
setopt EXTENDED_HISTORY # save timestamps, use history -f to get date and time
setopt HIST_FIND_NO_DUPS # dont find dups when reverse-searching history
setopt HIST_IGNORE_DUPS # do not save consecutive repeated commands
setopt HIST_NO_STORE # dont store the history command in history
setopt HIST_REDUCE_BLANKS # remove superfluous blanks from history
setopt SHARE_HISTORY # multiple shells retain the same history

HISTFILE=~/.history
HISTSIZE=999999999999999999 # number of lines in the HISTFILE
SAVEHIST=999999999999999999 # number of lines to save in HISTFILE

# Use vim as a manpager (instead of less)
# export MANPAGER="col -bx | vim -MRc 'set ft=man fdm=indent nonu nornu' -"
export MANPAGER="col -bx | vim -MRc 'set ft=man ts=2 nolist nomod' -"

export VISUAL="vim"
export EDITOR=$VISUAL

bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward # TODO: change to ctrl-shift-r

bindkey -v '^?' backward-delete-char

##### LOAD AUTOJUMP ############################################################
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

##### SOURCE OTHER FILES #######################################################
source_file ~/.aliases
source_file ~/.aliases.local
source_file ~/.zshrc.local
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fpath=(/usr/local/share/zsh-completions $fpath)
