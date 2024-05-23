#!/bin/sh

export GITHUB_TOKEN=$(gopass ${GITHUB_GOPASS_TOKEN:-"epcim/github-token"})
export GITLAB_TOKEN=$(gopass ${GITLAB_GOPASS_TOKEN:-"f5/gitlab-token"})

export GIT_WORKSPACE=$PWD
GIT_WORKSPACE_BIN="git-workspace"

# override with local bild
CARGO_BIN=$HOME/.cargo/bin
test -e "$CARGO_BIN/git-workspace" && GIT_WORKSPACE_BIN="$CARGO_BIN/git-workspace"

${GIT_WORKSPACE_BIN} update
${GIT_WORKSPACE_BIN} fetch

[[ -z ${AUTO_PULL} ]] && exit 0
for PULL in ${AUTO_PULL}; do
  #gitbatch --recursive-depth=0 --mode=fetch -q
  gitbatch --recursive-depth=0 --mode=pull --directory=$PULL -q
done


