export PATH=$PATH:~/go/bin
export PATH=$PATH:~/scripts/bin
export PATH=$PATH:~/pn-scripts/bin
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export TERM="xterm-color"

#export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
BREW_BIN="/usr/local/bin/brew"
if [ -f "/opt/homebrew/bin/brew" ]; then
    BREW_BIN="/opt/homebrew/bin/brew"
fi

if type "${BREW_BIN}" &> /dev/null; then
    export BREW_PREFIX="$("${BREW_BIN}" --prefix)"
    for bindir in "${BREW_PREFIX}/opt/"*"/libexec/gnubin"; do export PATH=$bindir:$PATH; done
    for bindir in "${BREW_PREFIX}/opt/"*"/bin"; do export PATH=$bindir:$PATH; done
    for mandir in "${BREW_PREFIX}/opt/"*"/libexec/gnuman"; do export MANPATH=$mandir:$MANPATH; done
    for mandir in "${BREW_PREFIX}/opt/"*"/share/man/man1"; do export MANPATH=$mandir:$MANPATH; done
fi

alias ll='ls -lhG'

alias oldbrew=/usr/local/bin/brew 
export PATH="/opt/homebrew/bin:$PATH"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[${BOLD}${MAGENTA}\]\u\[$WHITE\]@\[$ORANGE\]\h\[$WHITE\]: [\[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" - \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]] \$ \[$RESET\]"
export JAVA_HOME=`/usr/libexec/java_home -v 1.11`

if [ -f ~/pn-scripts/bin/hub.bash_completion.sh ]; then
  . ~/pn-scripts/bin/hub.bash_completion.sh 
fi

export PATH="$HOME/.cargo/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# https://stackoverflow.com/questions/65938739/when-i-try-to-use-gitk-it-gives-me-autorelease-pool-page-corrupted
# https://github.com/Homebrew/discussions/discussions/705
#alias gitk="sed -i .bak 's/zoomed/normal/g' ~/.config/git/gitk && /usr/local/bin/gitk"

# kubebuilder autocompletion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
. /usr/local/share/bash-completion/bash_completion
fi
. <(kubebuilder completion bash)

#java11
#export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

#jenv begin
export PATH="/Users/pnowojski/.jenv/shims:${PATH}"
source "/usr/local/Cellar/jenv/0.4.4/libexec/libexec/../completions/jenv.bash"
jenv rehash 2>/dev/null
export JENV_LOADED=1
unset JAVA_HOME
jenv() {
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}
#jenv end

#immerok dev
# ok (binary)
export ROK_ROOT_DIR="$HOME/cloud"
export PATH=$PATH:"$ROK_ROOT_DIR/ok/build"
# export PATH=$PATH:"$ROK_ROOT_DIR"/ok/dev
# rok (binary)
export PATH="$PATH":"$ROK_ROOT_DIR"/rok/build
# export PATH="$PATH":"$ROK_ROOT_DIR"/rok/dev

export FPATH="$FPATH":"$ROK_ROOT_DIR/"ok/build/completion
export FPATH="$FPATH":"$ROK_ROOT_DIR/"rok/build/completion

if [ ! -f "$ROK_ROOT_DIR/"ok/build/completion/_ok ]; then
  mkdir -p "$ROK_ROOT_DIR/"ok/build/completion
  ok completion bash > "$ROK_ROOT_DIR/"ok/build/completion/_ok
fi
. "$ROK_ROOT_DIR/"ok/build/completion/_ok

if [ ! -f "$ROK_ROOT_DIR/"rok/build/completion/_rok ]; then
  mkdir -p "$ROK_ROOT_DIR/"rok/build/completion
  rok completion bash > "$ROK_ROOT_DIR/"rok/build/completion/_rok
fi
. "$ROK_ROOT_DIR/"rok/build/completion/_rok

#immerok dev end
