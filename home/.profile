
###
# Profile
# - only the basics, cross-shell supported options here
# - work special/shell specific setup to ~/.${SHELL}rc.local


# editor
export EDITOR='nvim';
export KUBE_EDITOR='nvim';


# lang
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC=en_US.UTF-8

# ui
export BLOCKSIZE=K
unset GREP_OPTIONS

# SHORTCUTS
export CDPATH="~:~/Sync:~/Workspace::$CDPATH"
export SYNC="$HOME/Sync"
export WORK="$HOME/Workspace"
export HG2G="${HG2G:-$SYNC}" # for backward comp.

# PATH
# system priviledged user
export PATH="$PATH:/usr/bin:/sbin:/usr/sbin:/usr/X11R6/bin"
# system
export PATH="/usr/local/bin:/opt/bin:/snap/bin:$PATH"
# osx fixture
test "$(uname -s)" = "Darwin" && {
  test -e $HOME/bin-osxoverride && \
    export PATH="$HOME/bin-osxoverride:$PATH"
  # util-linux
  test -e /usr/local/opt/util-linux && {
    export PATH="/usr/local/opt/util-linux/bin:$PATH"
    export PATH="/usr/local/opt/util-linux/sbin:$PATH"
  }
}
# user
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/opt/bin:$PATH"

# term
export TERM=xterm-256color

export XDG_CONFIG_HOME=~/.config

####
## BREAK THE RULES, lazy user flavors below, user teminal only

[[ $(basename $SHELL) == "sh" ]] && exit 0 || true

which starship >/dev/null && eval "$(starship init $SHELL)"
which thefuck >/dev/null && eval "$(thefuck --alias f)"
#which thefuck >/dev/null && eval "$(thefuck --alias f --enable-experimental-instant-mode)"

# SSH
export SSH_KEY_PATH="~/.ssh/${USER}_rsa:~/.ssh/${USER}_ed25519:~/.ssh/epcim_rsa:~/.ssh/epcim_ed25519" # : delimited
if [ -z $SSH_AUTH_SOCK ] ; then
  S=(  /run/user/$(id -u)/ssh-agent.socket
       /run/user/$(id -u)/openssh_agent
     )
  for s in ${S[@]}; do
    test -e $s \
      && export SSH_AUTH_SOCK=$s\
      && break
  done
fi


# GPG
export GPG_TTY=$(tty)
if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
#else
#  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi


# GO
test -z "$GOPATH" &&\
  export GOPATH=$HOME/go
if [[ -z "$GOROOT" ]]; then
  # osx + brew
  test -e /usr/local/opt/go/libexec/bin &&\
    export GOROOT=/usr/local/opt/go/libexec
fi
export PATH="${GOPATH//://bin:}/bin:$PATH"
export PATH="${GOROOT//://bin:}/bin:$PATH"


# Python
export PYENV_ROOT=~/.pyenv
sourcePyenv() {
  PYENV=$(which pyenv)
  [[ -e $PYENV ]] && {
    eval "$(pyenv init -)"
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
  }
}


# Rust
export PATH="$HOME/.cargo/bin:$PATH"


# GCLOUD
sourceGcloud() {
  GSDK_PATHS="
  $SYNC/opt/google-cloud-sdk
  /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
  "
  for P in $GSDK_PATHS; do
  if [ -d "$P" ]; then
    source "$P/path.zsh.inc"
    source "$P/completion.zsh.inc"
    fi;
  done
}

