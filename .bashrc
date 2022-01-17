# Homebrew path
#export PATH=/opt/homebrew/bin:$PATH

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
export PS1='\[\e[00;33m\][$CONDA_DEFAULT_ENV]\[\e[00m\] \[\e[01;32m\]\h\[\e[00m\] \[\e[01;31m\]::\[\e[00m\] \[\e[01;32m\]\u\[\e[00m\] \[\e[01;36m\]\w\[\e[00m\]\[\e[00;35m\]$(__git_ps1)\[\e[00m\] \[\e[01;31m\]»\[\e[00m\] '
export PS2='» '

# I dunno
shopt -s checkwinsize

# Vi mode
set -o vi

# LS color
export LSCOLORS=GxBxhxDxfxhxhxhxhxcxcx
# Default editor and visual
export EDITOR='vim'
export VISUAL='vim'

# Alias
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias jn='jupyter notebook' 
alias jb='jupyter lab'
alias xop='xdg-open'
alias tce='conda activate $(tmux show-environment CONDA_DEFAULT_ENV | sed "s:^.*=::")'

# fzf
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#export FZF_DEFAULT_OPTS='
#    --color=hl:#dc322f,hl+:#dc322f,pointer:#FF0000'

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
