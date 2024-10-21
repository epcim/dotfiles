alias vim-norc 'vim -u NORC'
alias vim-none 'vim -u NONE'

fish_vi_key_bindings

function fish_user_key_bindings
    bind \ec append-copy
    bind \ep prepend-paste
    bind \ev prepend-vim
    bind \ey 'commandline -b | pbcopy'
    bind \e'>' 'commandline -a -- "| shiftr"'
    bind \e'<' 'commandline -a -- "| shiftl"'
    bind \es 'git st'
    bind \ed 'git di'
    bind \ex 'git x'
end

if which nvim > /dev/null
    set -gx EDITOR nvim
    alias vimdiff 'nvim -d'
    alias vim 'nvim'
end

