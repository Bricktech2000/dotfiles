set -g theme_display_user no
set -g theme_display_hostname no
set -g theme_color_scheme base16-dark

set -g fish_key_bindings fish_vi_key_bindings
fish_vi_key_bindings default
for mode in default insert visual
  bind -M $mode \r -m default execute
end
set fish_vi_force_cursor

set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

set -g EDITOR vim

alias c='clear'
alias e='exit'
if type -q exa
  alias ls='exa --sort modified --reverse --icons'
else
  alias ls='ls -rt'
end
alias ld=':' # nop
alias ll='ls -l'
alias la='ll -a'
alias lt='la --tree'
alias lv='v'
function cs; builtin cd $argv && ls; end;
function cd; builtin cd $argv && ld; end
function cl; builtin cd $argv && ll; end;
function ca; builtin cd $argv && la; end;
function ct; builtin cd $argv && lt; end;
function cv; builtin cd $argv && lv; end;
function hs; cd $SYNC_DIR; cs (python3 ~/.hd.py $argv); end;
function hd; cd $SYNC_DIR; cd (python3 ~/.hd.py $argv); end;
function hl; cd $SYNC_DIR; cl (python3 ~/.hd.py $argv); end;
function ha; cd $SYNC_DIR; ca (python3 ~/.hd.py $argv); end;
function ht; cd $SYNC_DIR; ct (python3 ~/.hd.py $argv); end;
function hv; cd $SYNC_DIR; cv (python3 ~/.hd.py $argv); end;
alias s='git status'
alias d='git diff'
alias a='git add'
alias A='git fetch --all --prune'
alias m='git commit -m'
alias g='git log --graph --pretty=format:"%Cred%h%Creset %C(bold blue)<%an>%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)" --abbrev-commit'
alias G='g --all'
alias r='git reset'
alias R='git reset --hard'
alias p='git push'
alias P='git push --force'
alias l='git pull --rebase'
alias V='git revert --no-commit'
alias k='git checkout'
alias b='git branch'
alias t='git stash'
alias T='git stash pop'
alias f='fuck --yeah'
alias F='fuck'
alias v='nvim'
alias pull='sudo ~/pull.sh'
alias restart='sudo ~/restart.sh'
alias server='~/server.sh'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

function fish_greeting
  # empty greeting
end

if type -q thefuck
  thefuck --alias | source
end

export PATH="$HOME/.cargo/bin:$PATH"
