
# RC
function source_rc
    for i in $argv; touch $i && source $i; end
end

if status --is-interactive
    set -l U (string replace "." "" $USER)
    source_rc ~/.config/fish/aliases.fish
    source_rc ~/.config/fish/config.{$U,local}.fish
end

if status --is-login
end

## Simplify
set -gx fish_greeting ''
# vi promt mode disabled
# function fish_mode_prompt; end
# funcsave fish_mode_prompt
# function prompt_login; end

set fish_function_path ~/.config/fish/functions/*/ $fish_function_path

set -gx GPG_TTY $(tty)

if which nvim 2>/dev/null
   function vim
       EDITOR=nvim chezmoi edit --watch "$argv[1]" 2>/dev/null || nvim $argv
   end
end

