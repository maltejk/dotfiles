# vim: filetype=sh
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export PATH=$HOME/.local/bin:$HOME/.local/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# https://blog.jonaspasche.com/index.html%3Fp=1297.html
# read this number of lines into history buffer on startup
# carefull with this, it will increase bash memory footprint and load time
export HISTSIZE=10000
# HISTFILESIZE is set *after* bash reads the history file
# (which is done after reading any configs like .bashrc)
# if it is unset at this point it is set to the same value as HISTSIZE
# therefore we must set it to NIL, in which case it isn't "unset",
# but doesn't have a value either, go figure
#unset HISTFILESIZE
export HISTFILESIZE=""

# load (home|linux)brew
case "$(uname -s )" in
  "Darwin")
    eval $(brew shellenv)
    # use system's ssh-add for keychain functionality
    alias ssh-add='/usr/bin/ssh-add'
    ;;
  "Linux")
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    ;;
esac

# on macOS
# env | grep BREW
# HOMEBREW_PREFIX=/usr/local
# HOMEBREW_CELLAR=/usr/local/Cellar
# HOMEBREW_REPOSITORY=/usr/local/Homebrew
source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"

# get it from here
# https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
source "$HOME/.bashrc.d/git-prompt.sh"

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"

# brew install kube-ps1
export KUBE_PS1_PREFIX=" ("
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_CTX_COLOR="black"
export KUBE_PS1_NS_COLOR="black"

# don't throw error below if not in kubesetup() context
kube_ps1 () {
  true
}

#prompt with git info and k8s foo
export PS1='[\t] \u@\h:\w$(kube_ps1)$(__git_ps1 " (%s) ")\$ '
#export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "$(kube_ps1) \\\$ "'

kubesetup () {
  KUBECONFIG_FILE=$HOME/.kube/config-${1}
  if [ -f $KUBECONFIG_FILE ]; then
    printf "loaded cluster config" ${1}
  else
    printf "available clusters: "
    (
      cd $HOME/.kube
      ( ls config-* 2>/dev/null || echo "none" ) | tr "\n" ' ' | sed 's/config-/- /g'
    )
    printf "\nnone chosen, using default\n"
    KUBECONFIG_FILE=$HOME/.kube/config
  fi
  source <(kubectl completion bash)
  complete -F __start_kubectl k
  export KUBECONFIG="$KUBECONFIG_FILE"
  source "$HOMEBREW_PREFIX/opt/kube-ps1/share/kube-ps1.sh"
  # remove ALL the emojis
  source "$HOME/.bashrc.d/kube-ps1-extended.sh"
  unset KUBECONFIG_FILE
}

alias helm2='$HOMEBREW_PREFIX/opt/helm@2/bin/helm'

alias k='kubectl'
alias kns='kubens'

alias ssh-noverify='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias scp-noverify='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

alias assh='ansible-ssh'
alias ascp='ansible-scp'

kssh () {
  ssh root@$(kubectl get node -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}' $1)
}

source "$HOME/.bashrc.d/$(hostname -s)" || true
