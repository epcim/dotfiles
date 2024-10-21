
# git
alias gs 'git status '
alias ga 'git add '
alias gb 'git branch -v --sort=committerdate'
alias gc 'git commit'
alias gd 'git diff'
alias gco 'git checkout '
alias gl 'git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gh 'git log --pretty=tformat:%H |xargs -n1 git show'

function gitCommitSlug -d "Return an commit Slug from last commit msg"
  git log -1 --pretty=%B |sed -e 's,[. :,\/"\\()\*], ,g' -e 's/ ./\U&/g' -e 's/ //g'|cut -c 1-25|head -n1
end

function gitBranchSlug -d "Return an commit Slug from local custombranch name or slug is created from last commit msg"
  set -l B $(git branch --show-current |sed -e 's,[. :,\/"\\()\*], ,g' -e 's/ ./\U&/g' -e 's/ //g'|cut -c 1-25)
  if string match -qr "$B" 'main|master|develop'
    gitCommitSlug
  else
    echo "$B"
  end
end 


