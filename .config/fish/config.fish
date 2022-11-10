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
alias ld=':' # nop
if type -q exa
  alias ls='exa --sort modified --reverse --icons'
else
  alias ls='ls -rt'
end
alias ll='ls -l'
alias la='ll -a'
alias lv='v'
function cd; builtin cd $argv && ld; end
function cs; builtin cd $argv && ls; end;
function cl; builtin cd $argv && ll; end;
function ca; builtin cd $argv && la; end;
function cv; builtin cd $argv && lv; end;
function hd; cd ~/Sync/; cd (python3 ~/.hd.py $argv); end;
function hs; cd ~/Sync/; cs (python3 ~/.hd.py $argv); end;
function hl; cd ~/Sync/; cl (python3 ~/.hd.py $argv); end;
function ha; cd ~/Sync/; ca (python3 ~/.hd.py $argv); end;
function hv; cd ~/Sync/; cv (python3 ~/.hd.py $argv); end;
alias s='git status'
alias d='git diff'
alias a='git add'
alias m='git commit -m'
alias g='git --no-pager log -n50 --graph --pretty=format:"%Cred%h%Creset %C(bold blue)<%an>%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)" --abbrev-commit'
alias r='git reset'
alias R='git reset --hard'
alias p='git push'
alias P='git push --force'
alias l='git pull --rebase'
alias V='git revert --no-commit'
alias k='git checkout'
alias b='git branch'
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
