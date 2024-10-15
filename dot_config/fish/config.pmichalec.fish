
# RC
function source_rc
    for i in $argv; touch $i && source $i; end
end

if status --is-interactive
    source_rc ~/.config/fish/config.{vi,f5}.fish

    which direnv &>/dev/null && direnv hook fish | source  || true
    which starship &>/dev/null && starship init fish | source  || true

    set CDPATH . ~/Sync ~/Work ~/Workspace
end

# Ctrl-o will open the selected file/directory in your editor of choice.
set fzf_dir_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

## set -g Z_SCRIPT_PATH $HOME/bin/z.sh

set -gx fish_greeting ''

## Simplify
# vi promt mode disabled
# function fish_mode_prompt; end
# funcsave fish_mode_prompt
# function prompt_login; end


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
