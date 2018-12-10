#!/bin/sh

# TODO: Write functions to do this stuff conditionally

RUBY_VERSION=2.2.2

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

brew install zsh
chsh -s $(which zsh)

brew install autojump
brew install git
brew install heroku-toolbelt
brew install imagemagick
brew install node
brew install phantomjs
brew install qt
brew install rbenv
brew install readline
brew install reattach-to-user-namespace
brew install ruby-build
brew install sqlite
brew install the_silver_searcher
brew install tmux
brew install vim
brew install caskroom/cask/brew-cask
brew install tree
brew install gtypist
brew install sl
brew install coreutils
brew install profanity --with-terminal-notifier
brew install ossp-uuid:w
brew install ctags
brew install ack


brew install openssl
brew unlink openssl && brew link openssl --force

brew install postgresql
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

brew install redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist

rbenv install "$RUBY_VERSION"
rbenv global "$RUBY_VERSION"
rbenv shell "$RUBY_VERSION"

gem install bundler
gem install pry-theme
gem install pry-remote
gem install pry-nav
gem install pry-stack_explorer
gem install pry-rails
rbenv rehash

brew install caskroom/cask/brew-cask

brew cask install dropbox
brew cask install flux
brew cask install google-chrome
brew cask install iterm2
brew cask install slack

# http://www.economyofeffort.com/2014/08/11/beyond-ctrl-remap-make-that-caps-lock-key-useful/
brew cask install karabiner

brew tap thoughtbot/formulae
brew install pick
brew install rcm

brew cleanup

if [[ ! -d "$HOME/dotfiles" ]]; then
  git clone git@github.com:vveleva/dotfiles.git $HOME/dotfiles
  env RCRC=$HOME/dotfiles/rcrc rcup
fi

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim "+:PluginInstall" "+:qa"

source $HOME/.osx
