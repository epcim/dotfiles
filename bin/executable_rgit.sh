#!/bin/bash
# To use it: source git_aliases

# Example: rgitall remote \;
#alias rgitall='find . -type d -name .git -execdir'
rgitall() {
  #find . -type d -name .git -execdir  git $@ \;
  for r in $(find . -type d -name .git); do
    echo "---"
    pushd $r/..
      git ${@}
    popd &> /dev/null
  done
}
alias rgitconfigs='find . -type d -name .git|xargs -n1 -I{} echo {}/config'

# Example: rgitbackup
# Example: rgit remote -vv
# Example: rgit fetch origin master
# Example: rgit pull
rgit() {
  c=$(alias "$@" |sed -e "s/.*='\(.*\)'/\1/" -e 's/\"/\\\"/g' -e 's/^git\s*//')
  [[ -z "$c" ]] && c="$@"
  rgitall "${c}"
}

rgitbackup() {
  tar czvf rgit-backup-$(date '+%Y-%m-%d').tgz $(rgitconfigs) ;\
}

# backup all content required, but not part of the repository
rgitbackupPrivate() {
  tar czvf rgitbackupPrivate-$(date '+%Y-%m-%d').tgz \
    $(find $1 -name PRIVATE.md -o -name PRIVATE -o -name .envrc)
}
