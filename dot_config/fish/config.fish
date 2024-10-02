
# RC
function source_rc
 touch $argv && source $argv
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

