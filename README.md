[[_TOC_]]

# Dotfiles

* Based on https://www.chezmoi.io.
* Can coexist with your existing chezmoi installation



## Init

```
chezmoi init --exclude encrypted \
  --ssh --guess-repo-url=false \
  -C ~/.config/chezmoi/chezmoi.toml \
  git@git.apealive.net:epcim/dotfiles.git
```

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

## Usage

See docs:
* https://www.chezmoi.io/user-guide/daily-operations/

TL;DR;

to update from upstream:
```
chez diff
chez apply -v 

# or
chez update

# to run install scripts
RUN_AFTER=utils chez apply

```

to track new dotfiles:
```
# to update your dotfiles with the shared configuratio:
chez git pull -- --autostash --rebase && chezmoi diff  
chez apply -v --dry-run
chez apply

# add files
chez add --follow ~/.zshrc.$HOSTAME
chez add --follow --template ~/.bashrc.$HOSTNAME
chez add --follow --encrypt ~/.secretFile

# edit/commit/diff
chez edit ~/.zshrc
chez git status/add/commit
```


## Docs

- https://www.chezmoi.io/user-guide
- https://www.chezmoi.io/reference
- https://www.chezmoi.io/reference/special-files-and-directories


## Resources delivered

* see ~/.cofig/chezmoi/chezmoi.toml (data.features, data.install)
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
    jq yq curl wget coreutils diffutils findutils gawk gnu-sed make just

```

#### recomended cli tools

Subject of `./run_after_utils.sh.tmpl` config script (in this repo).

```
brew install \
    jq yq stern gitbatch gopass curl wget bat direnv jsonnet
	terraform skopeo kustomize kubectl stern k9s eksctl \
    azure-cli awscli aws-iam-authenticator google-cloud-sdk \
    ansible ansible-lint
```

Link all GNU binnaries with common name (without "g" prefix) on your path:
```
  test -e ~/bin || mkdir ~/bin
  for i in $(ls /usr/local/bin/g*); do
      N=$(basename ${i/g//})
      ln -sf $i ~/bin/$N
  done
  export PATH="$HOME/bin:$PATH"
```


#### k8s utils
```
brew install krew
kubectl krew install rbac-tool
kubectl krew install advise-policy
kubectl krew install rolesum
kubectl krew install np-viewer
kubectl krew install ksniff
kubectl krew install view-serviceaccount-kubeconfig

# ci & build
brew install \
	cmake make autoconf automake
    just

```


#### neovim dependencies
```
brew install \
	fd \
	ripgrep \
	lazygit

curl https://raw.githubusercontent.com/rupa/z/master/z.sh -o ~/bin/z.sh
chmod u+x ~/bin/z.sh
```

### OSX Fonts

* https://www.nerdfonts.com/font-downloads

#### nerd fonts
```
brew tap homebrew/cask-fonts &&
	brew install --cask font-hack-nerd-font

brew install font-source-code-pro

# nerd fonts (all)
brew search nerd-font | grep font | xargs -n1 brew install
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

