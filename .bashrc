# CURR PROJECT STUFF
export PYTHONPATH=/Users/wren/fun/tinygrid
export JUPYTER_PATH=/Users/wren/fun/tinygrid
# Homebrew path
export PATH=/opt/homebrew/bin:$PATH
# Golang path
export PATH=/Users/wren/go/bin:$PATH
# User path
export PATH=/Users/wren/bin:$PATH
# Java path
export JAVA_HOME="JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.0.2.jdk/Contents/Home"

# append to the history file, don't overwrite it
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Source git `prompt for PS1
source '/Users/wren/.git-prompt.sh'

# Added brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Bash prompt personalize
get_exit_status(){
   es=$?
   if [ $es -eq 0 ]
   then
       echo -e ""
   else
       echo -e "${es} "
   fi
}
export PS1='\[\e[00;33m\][$CONDA_DEFAULT_ENV]\[\e[00m\] \[\e[01;32m\]\w\[\e[00m\]\[\e[00;35m\]$(__git_ps1)\[\e[00m\] \[\e[01;31m\]» $(get_exit_status)\[\e[00m\]' 
export PS2='» '

# I dunno
shopt -s checkwinsize

# Vi mode
set -o vi

# LS color
export LSCOLORS=GxBxhxDxfxhxhxhxhxcxcx
# Default editor and visual
export EDITOR='nvim'
export VISUAL='nvim'

# Autocomplete
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Alias
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias jn='jupyter notebook' 
alias jb='jupyter lab'
alias tce='conda activate $(tmux show-environment CONDA_DEFAULT_ENV | sed "s:^.*=::")'
alias ctags="`brew --prefix`/bin/ctags"
alias nv='nvim'
alias vi='nvim'
alias cat='bat --theme=base16 --paging=never'
alias wgit='watch -n 0.5 --color git -c color.status=always status'
# Delta with git, accept args just like git diff
function ddiff() {
  git diff $* | delta --features side-by-side --syntax-theme=ansi --paging never
}

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='
    --color=hl:#dc322f,hl+:#dc322f,pointer:#FF0000'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/wren/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/wren/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/wren/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/wren/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/Users/wren/miniforge3/bin:$PATH"
. "$HOME/.cargo/env"
