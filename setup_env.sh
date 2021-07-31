#!/bin/sh

# TODO: Write functions to do this stuff conditionally

RUBY_VERSION=2.7.1

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

brew install zsh
chsh -s $(which zsh)

brew install autojump
brew install git
brew install heroku-toolbelt
brew install node
brew install phantomjs
brew install qt
brew install readline
brew install reattach-to-user-namespace
brew install ruby-build
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

# install and setup rbenv
brew install rbenv

rbenv install "$RUBY_VERSION"
rbenv global "$RUBY_VERSION"
rbenv shell "$RUBY_VERSION"

rbenv rehash


brew install openssl
brew unlink openssl && brew link openssl --force

brew install postgresql
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

brew install redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist


gem install bundler
gem install pry-theme
gem install pry-remote
gem install pry-nav
gem install pry-stack_explorer
gem install pry-rails


brew install caskroom/cask/brew-cask

brew cask install dropbox
brew cask install google-drive
brew cask install google-chrome
brew cask install iterm2
brew cask install hammerspoon
brew cask install lastpass
brew cask install slack
brew cask install zoom
brew cask install postman
brew cask install graphiql
brew cask install telegram
brew cask install whatsapp
brew cask install divvy
brew cask install alfred
brew cask install ubersicht


brew tap thoughtbot/formulae
brew install pick
brew install rcm

brew cleanup

# TODO symlink all dotfiles into ~/
# if [[ ! -d "$HOME/dotfiles" ]]; then
#   git clone git@github.com:vveleva/dotfiles.git $HOME/dotfiles
#   env RCRC=$HOME/dotfiles/rcrc rcup
# fi


# Install vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim "+:PlugInstall" "+:qa"

source $HOME/.osx
