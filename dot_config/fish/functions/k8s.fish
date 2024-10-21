

# k8s
which kubecolor &>/dev/null && alias kubectl "kubecolor" || true
alias kluctl 'kluctl --no-update-check'
alias k 'kubectl'
alias kg 'k get pods -A | grep -i'
alias kp 'k get pods -A'
alias kq 'k get quota'
alias ke 'k get events --sort-by=".lastTimestamp"'
alias k9s 'k9s --refresh 30 -n all'

function kgp; kubectl get pods -A -o wide $argv; end
