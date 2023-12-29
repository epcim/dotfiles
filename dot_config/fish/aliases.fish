# Quick edits
alias ea 'vim ~/.config/fish/aliases.fish'
alias ef 'vim ~/.config/fish/config.fish'
alias eg 'vim ~/.gitconfig'
alias ev 'vim ~/.vimrc.local'
alias et 'vim ~/.tmux.conf'

alias vim-norc 'vim -u NORC'
alias vim-none 'vim -u NONE'


## CORES
####################################################
alias df 'command df -m'
alias j jobs
alias l 'ls -la --color'
alias ll 'ls -lrta --color'
alias ls 'command ls -FG'
alias lsn 'stat -c "%a %n" '
alias su 'command su -m'
alias map 'xargs -n1'
alias collapse "sed -e 's/  */ /g'"
alias cuts 'cut -d\ '
alias g git
alias c clear
alias v vim

####################################################
## VIM / FIND

function lsd -d 'List only directories (in the current dir)'
    command ls -d */ | sed -Ee 's,/+$,,'
end

alias notes 'ag "NOTE|WROKAROUND|TODO|HACK|FIXME|OPTIMIZE"'


function da -d "Allow or disallow .envrc after printing it."
    echo "------------------------------------------------"
    cat .envrc
    echo "------------------------------------------------"
    echo "To allow, hit Return."
    read answer
    direnv allow
end

function def -d "Quickly finds where a function or variable is defined."
    a -l "def\s+$argv"; or a -l "^\s*$argv\s*[=]"
end

function vimff
    vim (ffind -tf $argv)
end

function f
    ffind -tf | grep -v "/migrations/"
end

function fa
    ffind -tf
end

function vf
    f $argv | selecta | xargs -o vim
end

function vfa
    fa $argv | selecta | xargs -o vim
end

function va
    set pattern $argv[1]
    if test (count $argv) -gt 1
        set argv $argv[2..-1]
    else
        set argv
    end

    set ag_pattern (echo $pattern | sed -Ee 's/[<>]/\\\\b/g')
    set vim_pattern (echo $pattern | sed -E -e 's,([/=]),\\\\\1,g' -e 's,.*,/\\\\v&,')
    ag -l --smart-case --null $ag_pattern -- $argv ^/dev/null | xargs -0 -o vim -c $vim_pattern
end

function vaa
    set pattern $argv[1]
    if test (count $argv) -gt 1
        set argv $argv[2..-1]
    else
        set argv
    end

    set ag_pattern (echo $argv | sed -Ee 's/[<>]/\\\\b/g')
    set vim_pattern (echo $argv | sed -E -e 's,([/=]),\\\\\1,g' -e 's,.*,/\\\\v&,')
    ag -l --smart-case --null -a $ag_pattern -- $argv ^/dev/null | xargs -0 -o vim -c $vim_pattern
end

function vc
    if git modified -q $argv
        vim (git modified $argv | sed -Ee 's/^"(.*)"$/\1/')
    else
        echo '(nothing changed)'
    end
end

function vca
    if git modified -qi
        vim (git modified -i | sed -Ee 's/^"(.*)"$/\1/')
    else
        echo '(nothing changed)'
    end
end

function vu
    if git modified -u $argv
        vim (git modified -u $argv | sed -Ee 's/^"(.*)"$/\1/')
    else
        echo 'no files with conflicts'
    end
end

function vw
    vim (which "$argv")
end

####################################################
## GIT

alias gs='clear ;and git status'
alias gb='git branch'
alias gbranch='git rev-parse --abbrev-ref HEAD' #get current branch name
alias gl="clear ;and git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gt='git tag'
#alias grm='git rm'
alias gp='git push'
alias gbi='git bisect'
alias gbg='git bisect good'
alias gbb='git bisect bad'
alias gco='git checkout'
alias ggo='git checkout'
alias gm='git merge'
alias gmt='git mergetool'
alias gdt='git difftool'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gup='git stash ;and git pull --rebase ;and git stash apply'
#alias gr='git rebase'
#alias gri='git rebase -i'
alias gst='git stash'
alias gsta='git stash apply'
alias gunstage='git reset HEAD'

# checkout pull request
function gcopr
   git fetch origin pull/$argv/head:pr-$argv ;and git checkout pr-$argv;
end

alias ga 'git add'
alias gd 'git diff'
alias gc 'git commit'
alias gti git
alias a 'git amend'
alias gbr 'git recent-branches 2.days.ago'

function git-search
    git log -S"$argv" --pretty=format:%H | map git show 
end

## git gr (npm install -g git-run)
function grd
    gr @$argv[1..-1] git diff
end
function grdc
    gr @$argv[1..-1] git diff --cached
end
function grl
    gr @$argv[1..-1] git --no-pager log --decorate --graph --oneline -n 3
end
function grs
    gr @$argv[1..-1] git status
end

####################################################
## CLEANUPS
#
function cleanpycs
    find . -name '.git' -prune -o -name '__pycache__' -delete
    find . -name '.git' -prune -o -name '*.py[co]' -delete
end

function cleanorigs
    find . '(' -name '*.orig' -o -name '*.BACKUP.*' -o -name '*.BASE.*' -o -name '*.LOCAL.*' -o -name '*.REMOTE.*' ')' -print0 | xargs -0 rm -f
end

function cleandsstores
    find . -name '.DS_Store' -exec rm -f '{}' ';'
end


####################################################
## COLORIZE

# Linux/GNU /  # OSX
test -e /etc/lsb-release ;and set LS_COLORS dxfxcxdxbxegedabagacad ;or set LSCOLORS dxfxcxdxbxegedabagacad

# Colorized cat (will guess file type based on contents)
alias ccat 'pygmentize -g'

alias json 'prettify-json'


function colorize-pboard
    if test (count $argv) -gt 0
        set lang $argv[1]
    else
        set lang 'python'
    end
    pbpaste | strip-indents | color-syntax | pbcopy
end

function color-syntax
    if test (count $argv) -gt 0
        set lang $argv[1]
    else
        set lang 'python'
    end
    pygmentize -f rtf -l $lang
end


####################################################
# DIRECTORIES

function cdff --description "cd's into the current front-most open Finder window's directory"
    cd (ff $argv)
end

function ff
    echo '
    tell application "Finder"
        if (1 <= (count Finder windows)) then
            get POSIX path of (target of window 1 as alias)
        else
            get POSIX path of (desktop as alias)
        end if
    end tell
    ' | osascript -
end

alias cd.. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

alias md 'mkdir -p'

function take
    set -l dir $argv[1]
    mkdir -p $dir; and cd $dir
end


####################################################
## UTILS

alias cx 'chmod +x'
alias 'c-x' 'chmod -x'

function pdftext
    pdftotext -layout $argv[1] -
end

function serve
    if test (count $argv) -ge 1
        if python -c 'import sys; sys.exit(sys.version_info[0] != 3)'
            /bin/sh -c "(cd $argv[1] && python -m http.server)"
        else
            /bin/sh -c "(cd $argv[1] && python -m SimpleHTTPServer)"
        end
    else
        python -m SimpleHTTPServer
    end
end

function timestamp
    python -c 'import time; print(int(time.time()))'
end
