set fish_vi_force_cursor
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_visual block
set fish_cursor_replace underscore
set fish_cursor_replace_one underscore
set -g fish_key_bindings _vi_normal
# using `fish_vi_key_bindings default` doesn't seem to work, so we define
# a custom `fish_key_bindings` function and set mode to `default` manually
function _vi_normal; fish_vi_key_bindings; set fish_bind_mode default; end
for mode in default insert visual replace replace_one
  bind -M $mode \r -m default execute
  bind -M $mode \cg meta fish_prompt # similar to Vim's <c-g>
  bind -M $mode \cn accept-autosuggestion
end

# general
alias v='nvim'
alias x='nix-shell -p'
alias X='nix-shell --pure -p'
alias p='python3 -i -c "
import cmath, math, random, re, statistics as stats, string, sys, time
if not sys.stdin.isatty():
  sys.ps1 = sys.ps2 = \'\' # for `!!p<cr>` in Vim
"'

# navigation
zoxide init fish --no-cmd | source
alias ls='exa --sort modified --reverse --git'
alias ld=':' # no-op
alias ll='ls -l'
alias lt='ls -l --tree'
alias la='ls -l -a'
alias lv='v .'
function cs; __zoxide_z $argv && ls; end
function cd; __zoxide_z $argv && ld; end
function cl; __zoxide_z $argv && ll; end
function ct; __zoxide_z $argv && lt; end
function ca; __zoxide_z $argv && la; end
function cv; __zoxide_z $argv && lv; end
function ks; mkdir -p $argv && cs $argv; end
function kd; mkdir -p $argv && cd $argv; end
function kl; mkdir -p $argv && cl $argv; end
function kt; mkdir -p $argv && ct $argv; end
function ka; mkdir -p $argv && ca $argv; end
function kv; mkdir -p $argv && cv $argv; end
set -x LS_COLORS "*=0;37:di=1;0:ln=1;0:so=0:pi=0:ex=37:bd=0:cd=0:su=37:sg=37:tw=1;0:ow=1;0:or=1;37:pi=1;37"
set -x EXA_COLORS "da=37:uu=1;37:sn=37:sb=37:lp=1;37:ur=1;37:uw=1;37:ux=1;37:ue=1;37:gr=1;37:gw=1;37:gx=1;37:tr=1;37:tw=1;37:tx=1;37:su=1;37:sf=1;37:xa=1;37:ga=30:gm=30:gd=30:gv=30:gt=30"

# Git
alias d='git diff --no-prefix'
alias D='git diff --no-prefix --staged'
alias w='git diff --no-prefix --word-diff'
alias W='git diff --no-prefix --word-diff --staged'
alias s='git status --short'
alias a='git add'
alias A='git fetch --all --prune'
alias m='git commit -m'
alias g='git log --all --graph --pretty=format:"%C(244 ul)%h%d%Creset %cr %C(white bold)%an%Creset %s" --abbrev-commit'
alias r='git reset'
alias R='git reset --hard'
alias h='git push'
alias H='git push --force-with-lease'
alias l='git pull --rebase'
alias V='git revert --no-commit'
alias k='git checkout'
alias b='git branch'
alias B='git rebase'
alias t='git stash push --include-untracked'
alias T='git stash pop'
alias M='git blame --color-by-age --date=relative -w -C -C'

# trash-cli
if type -q trash-put
  alias rm='trash-put'
  alias rl='trash-list'
  alias ru='trash-restore'
  alias rd='trash-empty'
  alias rx='trash-rm'
end

# greps
alias rg='rg --smart-case --sortr modified --multiline --no-line-number --colors=path:fg:244 --colors=path:style:underline --colors=match:fg:white --colors=match:style:bold'
alias rc='rg --context 8'
alias rh='rg --passthru'
alias ltrep='~/.bin/ltrep -S'

# clipboard
if type -q termux-clipboard-get
  alias Y='termux-clipboard-set'
  alias P='termux-clipboard-get'
end
if type -q xclip
  alias Y='xclip -selection clipboard'
  alias P='xclip -selection clipboard -o'
end

# misc
alias less='less --ignore-case' # '--ignore-case' is smartcase
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
function dbless; ~/.bin/dbless (cat ~/.bin/token) $argv | Y &> /dev/null; end
function no-shit # example usage: no-shit gcc -O2 file.c
  source ~/.bin/no-shit.sh
  $argv (string split -n \n $CFLAGS)
  export CFLAGS=""
end

set -x GPG_TTY (tty)
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

function fish_greeting; end
function fish_mode_prompt; end
function fish_right_prompt; end
function fish_title; meta raw; end

function fish_prompt
  set -l _status $status
  set -l is_git_repo (git rev-parse --is-inside-work-tree 2> /dev/null)

  set -g _echo_raw 0

  if test $_status -ne 0
    _echo_bold -n '! ' # last command failed
  else if test (jobs -p | wc -l) -ne 0
    _echo_bold -n '% ' # jobs running
  else if test $IN_NIX_SHELL
    _echo_bold -n 'S ' # within nix-shell
  else if test $is_git_repo
    _echo_bold -n '& ' # within git repo
  else if test (id -u) -eq 0
    _echo_bold -n '# ' # user root
  else
    _echo_bold -n '$ ' # default
  end

  commandline -f repaint
end

function meta
  set -l _status $status
  set -l curr_commit (git rev-parse --abbrev-ref HEAD 2> /dev/null)
  set -l is_git_repo (git rev-parse --is-inside-work-tree 2> /dev/null)
  set -l repo_dirty (git diff --shortstat 2> /dev/null | tail -n1)
  if test "$curr_commit" = 'HEAD'; set curr_commit (git rev-parse --short HEAD 2> /dev/null); end
  set -l cmd_duration (math round $CMD_DURATION / 1000)
  echo -en '\r  '

  test "$argv" != 'raw'; set -g _echo_raw $status

  _echo_bold -n 'in'; echo -n " $(prompt_pwd) "
  if test "$IN_NIX_SHELL" = 'pure'
    echo -n '(pure) '
  else if test "$IN_NIX_SHELL" = 'impure'
    echo -n '(impure) '
  end
  if test $is_git_repo
    _echo_bold -n 'on'; echo -n " $curr_commit "
  end
  if test $repo_dirty
    echo -n '(dirty) '
  end
  _echo_bold -n 'as'; echo -n " $USER "
  if test $cmd_duration -gt 0
    _echo_bold -n 'took'; echo -n " $(date -d @$cmd_duration -u +%H:%M:%S) "
  end
  if test $_status -ne 0
    _echo_bold -n 'exit'; echo -n " $(printf '0x%02X' $_status) "
  end

  echo -en '\n'
end

function _echo_bold
  if test $_echo_raw -eq 1
    echo $argv
  else
    echo -en "\033[1m" # sets bold style
    echo $argv
    echo -en "\033[0m" # resets style
  end
end

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
