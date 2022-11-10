# dotfiles

## Creating this Repository

add the following to your shell config:

```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

then, run the following commands:

```bash
git init --bare ~/dotfiles
echo "dotfiles" >> ~/.gitignore
config config --local status.showUntrackedFiles no

config add .gitignore
config commit -m "initial commit"
config remote add origin <repo-url>
config push -u origin master
```

## Installing these Dotfiles

add the following to your shell config:

```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

then, run the following commands:

```bash
git clone --bare <repo-url> ~/dotfiles

config checkout
```

## Sources

- <https://youtu.be/tBoLDpTWVOM>
- <https://www.atlassian.com/git/tutorials/dotfiles>
