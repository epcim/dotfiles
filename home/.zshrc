#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

fpath=(~/.zsh $fpath)
test -d ~/.zsh && autoload -U ~/.zsh/*(:t)

if [ PMI_ZSHRC_SET = 0 ]; then exit 0 ; fi
export PMI_ZSHRC_SET=0

if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ] ; then
  startx --
fi

# Midnight Commander chdir enhancement
export LC_ALL=C
if [ -f /usr/share/mc/mc.gentoo ]; then
   . /usr/share/mc/mc.gentoo
fi


autoload -U compinit promptinit
compinit
promptinit; 
#prompt gentoo
prompt pws

#zmodload -i zsh/complist     # obarv� vypisovan� soubory
zstyle ':completion:*' list-colors $LS_COLORS

zstyle ':completion::complete:*' use-cache 1

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
# history specific options
for keymap in v a; do
      bindkey -$keymap ^f  history-incremental-search-backward
done

# Command history environment variables
HISTFILE=~/.history
export HISTFILE=~/.history
HISTSIZE=5000
SAVEHIST=5000
setopt append_history
setopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt hist_no_functions
setopt no_hist_beep
setopt hist_save_no_dups

# XML catalogs
#XML_CATALOG_FILES="~/hg2g/etc/xml/catalog ~/opt/conf/xml/catalog /etc/xml/catalog"
XML_CATALOG_FILES="~/hg2g/etc/xml/catalog /etc/xml/catalog"
export XML_CATALOG_FILES



function precmd {
# Display the directory in the xterm header line
        print -Pn "\e]2;%n@%m:%~\a"
#find a better test then an existing acpi for the battery state display
#if [[ -x /usr/bin/acpi ]] then
#    bat=" [${${${=$(acpi)}[4]}%,}%]%"
#else
#    bat=""
#fi
###        bat=""
#PROMPT=$(echo "$bat%(?..%{\e[41;38m%}%B-%?-%b%{\e[0m%} )%(1j.%{\e[01;32m%}[%j]%{\e[0m%} .)%n@%m:%~%# ")
###        RPROMPT=$(echo "%T$bat")
}


# this one is very nice:
# cursor up/down look for a command that started like the one starting on the command line
function history-search-end {
    integer ocursor=$CURSOR

    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
# Last widget called set $hbs_pos.
        CURSOR=$hbs_pos
    else
        hbs_pos=$CURSOR
    fi

    if zle .${WIDGET%-end}; then
# success, go to end of line
        zle .end-of-line
    else
# failure, restore position
        CURSOR=$ocursor
    return 1
        fi
}

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# some keys
#bindkey "\e[A" history-beginning-search-backward #cursor up
#bindkey "\e[B" history-beginning-search-forward  #cursor down
bindkey "\e[A" history-beginning-search-backward-end #cursor up
bindkey "\e[B" history-beginning-search-forward-end

## never ever beep ever
setopt NO_BEEP

## automatically decide when to page a list of completions
LISTMAX=0

## disable mail checking
#MAILCHECK=0

autoload -U colors
colors


## Custom rules ##############################################

# Shell functions
setenv() { export $1=$2 }    # kompatibilita s csh

#colors
#fg_red=%{\e[1;31m%}
#fg_green%{\e[1;32m%}
#fg_yellow=%{\e[1;33m%}
#fg_blue=%{\e[1;34m%}
#fg_pink=%{\e[1;35m%}
#fg_cyan=%{\e[1;36m%}
#fg_gray=%{\e[1;37m%}
#fg_darkgray=%{\e[1;30m%}
#fg_black=%{\e[0m%}

# Set prompts
PROMPT="%B%{$fg_bold[gray]%}%T%{$fg_bold[white]%}> %b"
RPS1="%{$fg_bold[white]%}<%{$fg_no_bold[green]%}%n%{$fg_bold[green]%}@%{$fg_no_bold[green]%}%m%{$fg_bold[white]%}:%{$bg_bold[black]%}%{$fg_bold[blue]%}%~%b"

#PS1='%B>%b'
#RPS1='%B<%h %m:%~%b'

bindkey -v                 # editor jako vi
#bindkey -e                   # editor jako emacs
bindkey ' ' magic-space      # mezern?k rozbaluje odkazy na historii

# desktop user switcher (simply clever)
alias adrika=gdmflexiserver
alias gdmsw=gdmflexiserver

#alias ls="ls -F --color"     # BARVY
alias sl="ls -F --color"     # BARVY
alias cp="nocorrect cp -i --reflink=auto"   # opatrn? kop?rov?n?, maz?n? a p?esuny
alias rm="nocorrect rm -i"
alias mv="nocorrect mv -i"
alias df='df -h'
#alias ls='ls -h --color=auto'
alias ls='ls -h'
#alias ll='ls -rtalh --color=auto' # bez ll nema smysl zit
alias ll='ls -rtalh' # bez ll nema smysl zit
alias du='du -h'
alias links='links -g'

alias ys="sudo yum search"
#alias ys="sudo yum  --enablerepo='epel' --enablerepo='rpmforge' search"
#alias ysa="sudo yum --enablerepo='*' search"
alias yi="sudo yum install -y"
#alias yi="sudo yum  --enablerepo='epel' --enablerepo='rpmforge' install -y"
#alias yia="sudo yum --enablerepo='*' install -y"
alias yum="sudo yum"
alias aptitude="sudo aptitude"
alias apt-get="sudo apt-get"
#alias agi="sudo apt-get install"
alias apt-search="sudo apt-cache search"
alias asi="sudo apt-cache search"
alias rpm="sudo rpm"
alias emerge="sudo emerge"
alias mplayer="mplayer -vo xv -stop-xscreensaver"
alias emerge-sync='sudo layman -S;emerge --sync; sudo eupdatedb'
alias cat_kismet_dump='tail -f --lines=+0 `ls -ctr /var/log/kismet/Kismet*.dump| tail -n1`'
alias solve_mp='sudo ~/bin/solve_mp '
#alias e='sudo emerge'
alias s='esearch'
alias g='egrep -i'

alias ip='sudo ip'
alias ifconfig='sudo ifconfig '
alias ipconfig='sudo ifconfig '
alias route='sudo route '
alias iptables='sudo iptables '

alias ssh-add='ssh-add < /dev/null'
alias vi='sudo vi'

#alias scrot='scrot "%Y-%m-%d_$wx$h.png" -e "mv $f ~/shots/$f"'
alias scrot='scrot "screenshot_`date "+%Y-%m-%d-%H%M"`_$RANDOM.png" -e "mv $f ~/shots/$f"'

#alias alock='alock -auth md5:hash=9240b8caac65bc6825d1c6e7f7cb1040 -cursor theme -bg shade:color=orange,shade=85'
#alias xlock='alock'
alias alock='alock -auth md5:hash=9240b8caac65bc6825d1c6e7f7cb1040 -cursor theme'

alias vimenc="vim -u ~/.vimrc_encrypted -x"

test -d /etc/init.d && {
for service in `cd /etc/init.d/; ls`
      do
                  alias "rc-${service}"="sudo /etc/init.d/${service}"
      done
}

alias svi='sudo vi'

# virtualenv aliases
# http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html
alias v.source='. /usr/local/bin/virtualenvwrapper.sh'
alias v='workon'
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv --no-site-packages'
alias v.mk_withsitepackages='mkvirtualenv'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'


# git
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

alias got='git '
alias get='git '

psg () { ps -ax | grep $* | grep -v grep }    # hled?n? v b???c?ch procesech

# Set options
export LANG=en_US.UTF-8
#export LANG=en_US
export LC_ALL=en_US.UTF-8
export LC=en_US.UTF-8
export BLOCKSIZE=K
export EDITOR=vim

#export PILOTRATE=115200
export PILOTRATE=1152000
export PILOTPORT=net:any


setopt EXTENDED_GLOB         # roz???en? ?ol?kov? znaky
setopt NO_CLOBBER            # ochrana p?i p?esm?rov?v?n? v?stup?
setopt CORRECTALL            # opravy p?eklep?
#setopt NO_BEEP              # nep?pat p?i chyb?ch

# File completion
setopt AUTOLIST              # vypisuje mo?nosti pro dopln?n?
setopt NO_LIST_AMBIGUOUS     # vypisuje je HNED, ne a? p?i druh?m <Tab>
setopt LIST_PACKED           # zkr?cen? v?pis
setopt AUTOCD		# doplni cd na zacatek jmena napsaneho adresare

zmodload -i zsh/complist     # obarv? vypisovan? soubory
LS_COLORS="di=01;32;40:$LS_COLORS"	# http://zsh.sunsite.dk/Guide/zshguide06.html
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

autoload zmv		         # skupinove presouvani a prejmenovani	zmv (*).doc $1.txt | zmv (**/)README $1CTIMNE
##autoload -U compinit         # aktivuje "standardn?" pravidla pro dopl?ov?n?
##compinit

## Customzed options ##############################################

expand-alias() {
	# for safety, in case there's an = which will mess things up...
	local alias=${LBUFFER#*=}
	if ! alias=$(alias $LBUFFER); then
		zle beep
		return 1
	fi
	LBUFFER=${(Q)${alias#*=}}
}

zle -N expand-alias
bindkey '^[^e' expand-alias 

alias grep="grep --color --directories=recurse --exclude='*~'" # pozor neuzivat k tomu GREP_OPTIONS 

export PATH=$PATH:/bin:/usr/bin:/sbin:/usr/sbin:/opt/bin/:~/bin:~/opt/bin:/usr/local/bin/:/usr/X11R6/bin/:~/opt/vuze/:~/opt/eclipse/:~/hg2g/dev/workspace-android/android-sdk-linux_86:~/hg2g/dev/workspace-android/android-sdk-linux_86/tools
#export PATH=$PATH:/usr/lib/jvm/java-1.6.0-ibm-1.6.0.8.1.x86_64/jre/bin/javaws
export PATH=$PATH:/opt/IBM/db2/V8.1/bin
export PATH=$PATH:/usr/lib/qt-3.3/bin
export PATH=/opt/openoffice4/program:$PATH

export CDPATH=".:~/hg2g"

psg () { ps -ax | grep $* | grep -v grep }    # hleda v bezicich procesech
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g CA="2>&1 | cat -A"
alias -g C='| wc -l'
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g ED="export DISPLAY=:0.0"
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
alias -g F=' | fmt -'
alias -g G='| egrep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g kk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g LL="2>&1 | less"
alias -g L="| less"
alias -g LS='| less -S'
alias -g MM='| most'
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g R=' > /c/aaa/tee.txt '
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g TL='| tail -20'
alias -g T='| tail'
alias -g US='| sort -u'
alias -g VM='/var/log/messages'
alias -g X0G='| xargs -0 egrep'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep'
alias -g X='| xargs'
alias mc="LANG=C mc"
#alias nautilus="nautilus --browser --no-desktop"


export PMI_ZSHRC_SET=1
export AWT_TOOLKIT=MToolkit

HOWTO="$HOME/hg2g/howto"
HG2GL="/hg2g/home/pmichalec/hg2g"

#lotus notes
export PATH=$PATH:/home/epcim/lotus/notes/data
export PATH=$PATH:/etc/alternatives
export PATH=$PATH:/opt/libreoffice3.5/program

wmname LG3D

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)