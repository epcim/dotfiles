
# RC
function source_rc
 touch $1 && source $1
end

if status --is-login
    set -l U (string replace "." "" $USER)
    source_rc ~/.config/fish/aliases.fish
    source_rc ~/.config/fish/config.{$U,local}.fish
    set CDPATH . ~/Sync ~/Work
    direnv hook fish | source
end


## Simplify
set -gx fish_greeting ''
# vi promt mode disabled
# function fish_mode_prompt; end
# funcsave fish_mode_prompt
function prompt_login; end

