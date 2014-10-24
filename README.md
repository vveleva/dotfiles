# Dotfiles

### Installation

Download and run the install script:

```sh
curl https://raw.githubusercontent.com/vveleva/dotfiles/master/setup_env.sh | sh
```

Alternatively, clone the repository, review/edit the dotfiles, and
install manually.

If you don't already have rcm:

```sh
brew tap thoughtbot/formulae
brew install rcm
```

Then, to install:

```sh
git clone git@github.com:vveleva/dotfiles.git $HOME/dotfiles
env RCRC=$HOME/dotfiles/rcrc rcup
```

Much of this configuration is stolen from the [Thoughtbot dotfiles
repo](https://github.com/thoughtbot/dotfiles).

