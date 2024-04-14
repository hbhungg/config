# append to the history file, don't overwrite it
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Source git `prompt for PS1
if [ -f ~/.git-prompt.sh ]; then
  GIT_PROMPT_ONLY_IN_REPO=1
  source "${HOME}/.git-prompt.sh"
fi

# Git autocomplete
[[ -r "${HOME}/.git-completion.bash" ]] && . "${HOME}/.git-completion.bash"

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
export PS1='\[\e[01;38m\]\u@\h\[\e[00m\] \[\e[01;32m\]\w\[\e[00m\]\[\e[00;35m\]$(__git_ps1)\[\e[00m\] \[\e[01;31m\]» $(get_exit_status)\[\e[00m\]' 
export PS2='» '
export TERM=xterm-256color

# I dunno
shopt -s checkwinsize

# Vi mode
set -o vi

# LS color
export LSCOLORS=GxBxhxDxfxhxhxhxhxcxcx
export LS_COLORS=GxBxhxDxfxhxhxhxhxcxcx
# Default editor and visual
export EDITOR='nvim'
export VISUAL='nvim'

# Autocomplete
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
complete -C 'aws_completer' aws

# Alias
alias grep='grep --color=auto'
alias vi='nvim'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias jn='jupyter notebook' 
alias jb='jupyter lab'
alias tce='conda activate $(tmux show-environment CONDA_DEFAULT_ENV | sed "s:^.*=::")'
alias ctags="`brew --prefix`/bin/ctags"
alias cat='bat --theme=base16 --paging=never'
alias wgit='watch -n 0.5 --color git -c color.status=always status'
alias wlog='watch -n 0.5 --color -n1 git --no-pager log --color --oneline --graph -20'
alias activate='source venv/bin/activate'
alias tt='tree'
# Delta with git, accept args just like git diff
function ddiff() {
  git diff $* | delta --features side-by-side --syntax-theme=ansi --paging never --file-style 'red bold ul'
}

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='
    --color=hl:#dc322f,hl+:#dc322f,pointer:#FF0000'

. "$HOME/.cargo/env"

# PATH
export MODULAR_HOME="/Users/hung/.modular"
export PATH="/Users/hung/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
export PATH="$HOME/bin/:$PATH"
export PATH="/sbin/:$PATH"
