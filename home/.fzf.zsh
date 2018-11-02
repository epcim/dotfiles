# Setup fzf
# ---------
if [[ ! "$PATH" == */home/pmichalec/.linuxbrew/opt/fzf/bin* ]]; then
  export PATH="$PATH:/home/pmichalec/.linuxbrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/pmichalec/.linuxbrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/pmichalec/.linuxbrew/opt/fzf/shell/key-bindings.zsh"

