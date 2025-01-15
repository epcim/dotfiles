function vim
    if test (count $argv) -eq 0 
        nvim
    else
        chezmoi verify $argv[1] &> /dev/null && chezmoi edit --watch --hardlink=false $argv[1] || nvim $argv
    end
end

function vi
  vim $argv
end

function vimdiff
  nvim -d $argv
end

