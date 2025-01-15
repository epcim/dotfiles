[[_TOC_]]

# Dotfiles

* Based on https://www.chezmoi.io.
* Can coexist with your existing chezmoi installation


## Init

Prereq, with alternative destinations (run these first):
```sh

#NOTE: ONLY IF YOU DONT HAVE INSTALLED IT YET
cd $HOME
git clone https://github.com/Homebrew/brew homebrew
curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
export PATH=$HOME/homebrew/bin:$PATH
# ^^
#NOTE: you will need to configure your `HOMEBREW_PREFIX` if it diverts from `~/homebrew` or `/opt/homebrew`
#The best practice: `HOMEBREW_PREFIX=~/homebrew`, one or other can exist, see `.config/fish/config.f5.fish`

# Install minimum & dotfiles tools
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
```

Prereq, otherwise:
```sh
xcode-select --install
brew install -q \
    jq yq curl wget coreutils diffutils findutils gawk gnu-sed gnu-tar rsync make just age chezmoi nnn

#NOTE: ONLY IF YOU USE IT FROM DAY ONE(takes more time)
brew install -q gopass
```


Init dotfiles:
```sh
chezmoi init --exclude encrypted \
  --ssh --guess-repo-url=false \
  -C ~/.config/chezmoi/chezmoi.toml \
  git@git.apealive.net:epcim/dotfiles.git

  chezf5 apply -v
```

> Note: the working directory for chezmoi is ~/.config/chezmoi

### Overlays

use an alias and alternative path for source directory just in case you alread use `chezmoi`
```
FLAVOR=ape
echo 'alias chez$FLAVOR="chezmoi --source ~/.local/share/chezmoi-$FLAVOR --config ~/.config/chezmoi/chezmoi-$FLAVOR.toml' | tee -a ~/.profile"
echo 'alias chez="chez$FLAVOR"
```

to init:
```
FLAVOR=ape
chez$FLAVOR \
  --ssh --guess-repo-url=false init\
  -C ~/.config/chezmoi/chezmoi-$FLAVOR.toml \
  git@git.apealive.net:epcim/dotfiles-$FLAVOR.git
```

## How it works & Usage

This repo will deliver the bestpractice dotfiles. It's up to you to use them.

> we dont intend to change your current setup and dont clash with default user configuration
> if feasible we deliver ex: `.zshrc.$FLAVOR` or `.gitconfig.$FLAVOR`.

To hook f5 configuration and profiles in your existing dotfiles files.
Load them your own way, for example in your `~/.zshrc, ~/.bashrc`:
```sh
source $HOME/.profile
source $HOME/.zshrc.$FLAVOR
```


## Daily operations

See docs:
* https://www.chezmoi.io/user-guide/daily-operations/

TL;DR;

```sh
# update
chezmoi diff
chezmoi apply -v 

# or
chezmoi update

# to run install scripts
RUN_AFTER=utils chezmoi apply

# add files
chezmoi add --follow ~/.zshrc.$HOSTNAME
chezmoi add --follow --template ~/.bashrc.$HOSTNAME

# edit/commit/diff
vim ~/.config/fish/config.fish # will auto-trigger an alias with chezmoi edit as below
chezmoi edit ~/.gitconfig.$HOSTNAME
chezmoi edit --watch ~/.config/fish/config.$HOSTNAME.fish
chezmoi git status/add/commit


# to update your dotfiles with the shared configuration:
chezmoi git pull -- --autostash --rebase && chezmoi diff
chezmoi apply -v --dry-run --exclude=scripts
chezmoi apply --exclude=scripts
chezmoi apply


# diff diverted files manually
chezf5 diff  | grep 'diff --git' | sed -e 's,a/,~/,' -e 's,b/\.,dot_,' -e 's,b/,,' -e 's,diff --git,vimdiff,'
```


## Docs

- https://www.chezmoi.io/user-guide
- https://www.chezmoi.io/reference
- https://www.chezmoi.io/reference/special-files-and-directories
- https://www.chezmoi.io/links/related-software/


## Resources delivered

* see .chezmoi.toml (data.features)
* shell and common cli configuration
* sre common utilities


## Once uppone you get new gear

Apply on your wish.


### Configs

#### Git

```
[includeIf "file:~/.gitconfig.ape"]
  path = .gitconfig.ape
```

Sign your commits:
```
TBD
```

### Developer prerequisities for CLI

#### minimum

On OSX, to use deployment model scripts, ie: ("make render")

```
  brew install -q \
    jq yq curl wget coreutils diffutils findutils gawk gnu-sed gnu-tar rsync make just age \
    gopass chezmoi nnn direnv bat

```

#### recomended cli tools

Subject of `./.run_onchange_utils.sh.toml` config script (in this repo).
Mind it will either rename & link all GNU binnaries with common name (without "g" prefix) on your `~/bin`.



#### k8s utils
```
brew install krew
kubectl krew install rbac-tool
kubectl krew install advise-policy
kubectl krew install rolesum
kubectl krew install np-viewer
kubectl krew install ksniff
kubectl krew install view-serviceaccount-kubeconfig
```

# ci & build
```
brew install \
	cmake make autoconf automake just

```

#### neovim, AstroVim

Dependencies: https://docs.astronvim.com/

```
brew install \
	fd \
	ripgrep \
	lazygit
```

### OSX Fonts

* https://www.nerdfonts.com/font-downloads

#### nerd fonts
```
brew tap homebrew/cask-fonts

brew install font-hack-nerd-font
brew install font-source-code-pro

# nerd fonts (all)
brew search nerd-font | grep font | xargs -n1 brew install
```

### Starhip configuration


```
starship preset tokyo-night -o ~/.config/starship.toml
starship preset plain-text-symbols -o ~/.config/starship.toml
```

### iTerm2

```
Go to the Iterm settings -> Profiles -> Text

* hack-nerd-font
* jetbrains-mono-nerd-font
```

### OSX Setup

```
sudo scutil --set HostName FIXME
```

make apple hardware usable for people:
```
# from: https://gist.github.com/saetia/1623487

# Enable character repeat on keydown
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Set default Finder location to home folder (~/Workspace)
defaults write com.apple.finder NewWindowTarget -string "PfLo" &&
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Workspace" # PERSONAL FLAVOR !

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Disable ext change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Trackpad: map bottom right corner to right-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2 && \
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true && \
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1 && \
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Disable Accented Character menu
#defaults write -g ApplePressAndHoldEnabled -bool false
```

