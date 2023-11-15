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
  bind -M $mode \cl 'clear; fish_prompt'
  bind -M $mode \cg 'meta; fish_prompt' # similar to Vim's <C-g>
end

# general
alias v='nvim'
alias x='nix-shell -p'
alias X='nix-shell --pure -p'
alias c='clear'
alias e='exit'

# navigation
alias ls='exa --sort modified --reverse --icons --git'
alias ld=':' # no-op
alias ll='ls -l'
alias lt='ls -l --tree'
alias la='ls -l -a'
alias lv='v .'
function cs; _cd_checked $argv && ls; end;
function cd; _cd_checked $argv && ld; end
function cl; _cd_checked $argv && ll; end;
function ct; _cd_checked $argv && lt; end;
function ca; _cd_checked $argv && la; end;
function cv; _cd_checked $argv && lv; end;
function hs; builtin cd ~/; cs (python3 ~/.hd.py $argv); end;
function hd; builtin cd ~/; cd (python3 ~/.hd.py $argv); end;
function hl; builtin cd ~/; cl (python3 ~/.hd.py $argv); end;
function ht; builtin cd ~/; ct (python3 ~/.hd.py $argv); end;
function ha; builtin cd ~/; ca (python3 ~/.hd.py $argv); end;
function hv; builtin cd ~/; cv (python3 ~/.hd.py $argv); end;
function _cd_checked; if test "$argv" = '.'; return 1; end; builtin cd $argv; end

# git
function d; git diff --no-prefix --color=always $argv | sed -z "s/.\{13\}diff --[^\n]*//g; s/\n.\{13\}index[^\n]*//g; s/\n.\{13\}\(new\|deleted\) file mode[^\n]*//g; s/\n.\{13\}---[^\n]*//g; s/+++ //g" | $PAGER -RFX; end;
alias s='git status --short'
alias S='d HEAD --stat'
alias a='git add'
alias A='git fetch --all --prune'
alias m='git commit -m'
alias g='git log --all --graph --pretty=format:"%C(244 ul)%h%d%Creset %cr %C(white bold)%an%Creset %s" --abbrev-commit'
alias G='g --stat'
alias r='git reset'
alias R='git reset --hard'
alias h='git push'
alias H='git push --force'
alias l='git pull --rebase'
alias V='git revert --no-commit'
alias k='git checkout'
alias b='git branch'
alias B='git rebase'
alias t='git stash push'
alias T='git stash pop'

# trash-cli
alias rl='trash-list'
alias ru='trash-restore'
alias rd='trash-empty'
alias rx='trash-rm'
if type -q trash-put
  alias rm='trash-put'
end

# ripgrep
alias rg='rg --smart-case --sortr modified --multiline --no-line-number --colors=path:fg:244 --colors=path:style:underline --colors=match:fg:white --colors=match:style:bold'
alias rc='rg --context 8'
alias rh='rg --passthru'

# xclip
alias y='xclip -selection clipboard'
alias p='xclip -selection clipboard -o'

# thefuck
alias f='fuck'
alias F='fuck --yeah'
if type -q thefuck
  thefuck --alias | source
end

# config
alias config='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

set -x EXA_COLORS "da=37:uu=1;37:sn=37:sb=37:lp=1;37:ur=1;37:uw=1;37:ux=1;37:ue=1;37:gr=1;37:gw=1;37:gx=1;37:tr=1;37:tw=1;37:tx=1;37:su=1;37:sf=1;37:xa=1;37:ga=30:gm=30:gd=30:gv=30:gt=30"
set -x LS_COLORS "*=0;37:di=1;0:ln=1;0:so=0:pi=0:ex=37:bd=0:cd=0:su=37:sg=37:tw=1;0:ow=1;0:or=1;37:pi=1;37"
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

alias clear='fish_greeting'
function fish_greeting
  echo -en "\033[2J\033[H" # clears screen and homes cursor
  echo -en "\033[38;5;240m\n" # sets grey foreground color
  # move to column 1000, then move left (24 + 2) columns, then print line
  echo -en "\033[1000G\033[26D      ,+*%%@@%%*+,      \n"
  echo -en "\033[1000G\033[26D   :*@@@@@@@@@@@@@@*:   \n"
  echo -en "\033[1000G\033[26D  *@@@@@@#*++*#@@@@@@*  \n"
  echo -en "\033[1000G\033[26D #@@@@@%+++::+++%@@@@@# \n"
  echo -en "\033[1000G\033[26D+@@@@@@*+++**+++#@@@@@@+\n"
  echo -en "\033[1000G\033[26D%@@@@@@%+::::::+%@@@@@@%\n"
  echo -en "\033[1000G\033[26D%@@@@@@@@#*++*#@@@@@@@@%\n"
  echo -en "\033[1000G\033[26D+@@@@#*+=+@@@@+=+*#@@@@+\n"
  echo -en "\033[1000G\033[26D #@@#:::::%@@%:::::#@@# \n"
  echo -en "\033[1000G\033[26D  *@#:::::+@@+:::::#@*  \n"
  echo -en "\033[1000G\033[26D   :*::::::**::::::*:   \n"
  echo -en "\033[1000G\033[26D     ''\"--::::--\"''     \n"
  echo -en "\033[13A" # moves up (12 + 1) lines
  echo -en "\033[0m" # resets color
end

function fish_mode_prompt; end # empty mode prompt
function fish_right_prompt; end # empty right prompt
function fish_title; meta; end

function fish_prompt
  set -l _status $status
  set -l is_git_repo (git rev-parse --is-inside-work-tree 2> /dev/null) # TODO duplicated

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
  echo -en "\033[1m" # sets bold style
  echo $argv
  echo -en "\033[0m" # resets style
end

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
