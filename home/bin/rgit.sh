#!/bin/sh
# To use it: source git_aliases

# Example: rgitall remote \;
alias rgitall='find . -type d -name .git -execdir'
alias rgitconfigs='find . -type d -name .git|xargs -n1 -I{} echo {}/config'

# Example: rgitbackup
# Example: rgit remote -vv
# Example: rgit git fetch origin master
# Example: rgit git pull
rgit() {
  rgitall "$@" \;
}

rgitbackup() {
  tar czvf rgit-backup-$(date '+%Y-%m-%d').tgz $(rgitconfigs) ;\
}

# backup all content required, but not part of the repository
rgitbackupPrivate() {
  tar czvf rgitbackupPrivate-$(date '+%Y-%m-%d').tgz \
    $(find $1 -name PRIVATE.md -o -name PRIVATE -o -name .envrc)
}
