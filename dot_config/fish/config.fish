## DEPRECATED
## Path to Oh My Fish install.
#set -gx OMF_PATH /Users/pmichalec/.local/share/omf
## Customize Oh My Fish configuration path.
##set -gx OMF_CONFIG /Users/pmichalec/.config/omf
## Load oh-my-fish configuration.
## source $OMF_PATH/init.fish
## z
## set -g Z_SCRIPT_PATH $HOME/bin/z.sh
####
# rbenv
#function init_rbenv
#    set LD_LIBRARY_PATH $HOME/.rbenv/versions/(cat $HOME/.rbenv/version)/lib $LD_LIBRARY_PATH
#    set PATH $HOME/.rbenv/bin $PATH; and \
#    set PATH $HOME/.rbenv/shims $PATH; and \
#    rbenv rehash >/dev/null ^&1
#    rbenv init - fish | source
#end
#test -e $HOME/.rbenv ; and init_rbenv
####
# chef
#test -e ~/.chefdk;and chef shell-init fish | source


# HOMESICK
# source $HOME/.homesick/repos/homeshick/homeshick.fish

# RC
# source $HOME/.oh-my-fish
source $HOME/.config/fish/aliases.fish


#set fish_color_hostname 'a67523'
set -gx fish_greeting ''

## Key bindings
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

# Interactive/login shells
if status --is-login
    test -f ~/.fishrc.$ENV && . ~/.fishrc.$ENV
    test -f ~/.fishrc.local && . ~/.fishrc.local
end
if status --is-interactive
    set CDPATH . ~/Sync ~/Workspace
    direnv hook fish | source
end


## Simplify
# vi promt mode disabled
# function fish_mode_prompt; end
# funcsave fish_mode_prompt
function prompt_login; end


## Customizations
function demo-mode
    function fish_prompt
        set last_status $status
        printf '$ '
    end
end

function git_current_branch -d 'Prints a human-readable representation of the current branch'
  set -l ref (git symbolic-ref HEAD ^/dev/null; or git rev-parse --short HEAD ^/dev/null)
  if test -n "$ref"
    echo $ref | sed -e s,refs/heads/,,
    return 0
  end
end

function git_prompt
    if git rev-parse --show-toplevel >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
        printf '%s' (git_current_branch)
        set_color green
        #git_prompt_status
        set_color normal
    end
end

function virtualenv_prompt
    if [ -n "$VIRTUAL_ENV" ]
        printf ' inside '
        set_color yellow
        printf '%s ' (basename "$VIRTUAL_ENV")
        set_color normal
    end
end



#################################################
## SSH && SSH AGENT (SEE FUNCTIONS)
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
	if [ -n "$SSH_AGENT_PID" ]
    		ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    		if [ $status -eq 0 ]
        		test_identities
    		end
	else
    		if [ -f $SSH_ENV ]
        		. $SSH_ENV > /dev/null
    		end
    	ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    	if [ $status -eq 0 ]
        	test_identities
    	else
    		echo "Initializing new SSH agent ..."
	        ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    		echo "succeeded"
		chmod 600 $SSH_ENV 
		. $SSH_ENV > /dev/null
    		ssh-add
	end
	end
end

function test_identities
  ssh-add -l | grep "The agent has no identities" > /dev/null
  if [ $status -eq 0 ]
      ssh-add
      if [ $status -eq 2 ]
          start_agent
      end
  end
end

start_agent
