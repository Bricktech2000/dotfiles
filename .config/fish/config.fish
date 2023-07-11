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

alias c='clear'
alias e='exit'
alias ls='exa --sort modified --reverse --icons --git'
alias ld=':' # nop
alias ll='ls -l'
alias lt='ls -l --tree'
alias la='ls -l -a'
alias lv='v'
function cs; builtin cd $argv && ls; end;
function cd; builtin cd $argv && ld; end
function cl; builtin cd $argv && ll; end;
function ct; builtin cd $argv && lt; end;
function ca; builtin cd $argv && la; end;
function cv; builtin cd $argv && lv; end;
function hs; cd $SYNC_DIR; cs (python3 ~/.hd.py $argv); end;
function hd; cd $SYNC_DIR; cd (python3 ~/.hd.py $argv); end;
function hl; cd $SYNC_DIR; cl (python3 ~/.hd.py $argv); end;
function ht; cd $SYNC_DIR; ct (python3 ~/.hd.py $argv); end;
function ha; cd $SYNC_DIR; ca (python3 ~/.hd.py $argv); end;
function hv; cd $SYNC_DIR; cv (python3 ~/.hd.py $argv); end;
function d; git diff --no-prefix --color=always $argv | sed -z "s/.\{13\}diff --[^\n]*//g; s/\n.\{13\}index[^\n]*//g; s/\n.\{13\}\(new\|deleted\) file mode[^\n]*//g; s/\n.\{13\}---[^\n]*//g; s/+++ //g" | less -RFX; end;
alias s='git status --short'
alias S='d HEAD --stat'
alias a='git add'
alias A='git fetch --all --prune'
alias m='git commit -m'
alias g='git log --all --graph --pretty=format:"%C(244 ul)%h%d%Creset %cr %C(white bold)%an%Creset %s" --abbrev-commit'
alias G='g --stat'
alias r='git reset'
alias R='git reset --hard'
alias p='git push'
alias P='git push --force'
alias l='git pull --rebase'
alias V='git revert --no-commit'
alias k='git checkout'
alias b='git branch'
alias B='git rebase'
alias t='git stash'
alias T='git stash pop'
alias f='fuck --yeah'
alias F='fuck'
alias v='nvim'
alias pull='sudo ~/pull.sh'
alias restart='sudo ~/restart.sh'
alias server='~/server.sh'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias grep='rg --smart-case --sortr modified --multiline --no-line-number --colors=path:fg:244 --colors=path:style:underline --colors=match:fg:white --colors=match:style:bold'

set -x EXA_COLORS "da=37:uu=1;37:sn=37:sb=37:lp=1;37:ur=1;37:uw=1;37:ux=1;37:ue=1;37:gr=1;37:gw=1;37:gx=1;37:tr=1;37:tw=1;37:tx=1;37:su=1;37:sf=1;37:xa=1;37:ga=30:gm=30:gd=30:gv=30:gt=30"
set -x LS_COLORS "*=0;37:di=1;0:ln=1;0:so=0:pi=0:ex=37:bd=0:cd=0:su=37:sg=37:tw=1;0:ow=1;0:or=1;37:pi=1;37"
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

function fish_greeting
  # empty greeting
end

if type -q thefuck
  thefuck --alias | source
end

export PATH="$HOME/.cargo/bin:$PATH"
