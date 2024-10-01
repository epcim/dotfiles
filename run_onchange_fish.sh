#!/bin/sh

test -e ~/.config/fish || exit 0
test -e ~/.config/fish/functions/install-fisher.fish || {
cat <<-EOF >| ~/.config/fish/functions/install-fisher.fish 
function install-fisher
    cd $HOME/.config/fish
    # https://github.com/jorgebucaran/fisher
    curl -sL https://git.io/fisher | source
    and fisher install jorgebucaran/fisher
    and git checkout fish_plugins
    and fisher update
    and fish -c update-settings
    and exec fish
end
EOF
}

echo ""
echo "First to run:"
echo " fish -c install-fisher"
echo ""
echo "Consider plugins:"
echo " fisher install barnybug/docker-fish-completion
 fisher install edc/bass
 fisher install jethrokuan/z
 fisher install jorgebucaran/fisher
 fisher install kidonng/nix-completions.fish
 fisher install lgathy/google-cloud-sdk-fish-completion
 fisher install markcial/upto
 fisher install orefalo/grc
"
