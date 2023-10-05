
#/bin/bash -x

# change nvim symlink to one of "nvim.astro", "nvim.lazy"
unlink nvim
ln -sf nvim.${1:-astro} nvim

# conditinaly delete directory ~/.local/share/nvim.bak if exist
[ -d ~/.local/share/nvim.bak ] && rm -rf ~/.local/share/nvim.bak
[ -d ~/.local/state/nvim.bak ] && rm -rf ~/.local/state/nvim.bak
[ -d ~/.cache/nvim.bak ] && rm -rf ~/.cache/nvim.bak
mv -f ~/.local/share/nvim ~/.local/share/nvim.bak
mv -f ~/.local/state/nvim ~/.local/state/nvim.bak
mv -f ~/.cache/nvim ~/.cache/nvim.bak

