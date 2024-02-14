# dotfiles

_A repository of my dotfiles_

## Repository Creation

To create a similar dotfiles repository, add the following to your shell config:

```bash
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Then, run the following commands:

```bash
git init --bare ~/dotfiles
echo "dotfiles" >> ~/.gitignore
dot config --local status.showUntrackedFiles no

dot add .gitignore
dot commit -m "initial commit"
dot remote add origin <repo-url>
dot push -u origin master

mv /etc/nixos/ ~/.nixos # on NixOS
ln -s ~/.nixos/ /etc/nixos # on NixOS
```

## Installation

To clone these dotfiles to your machine, add the following to your shell config:

```bash
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Then, run the following commands:

```bash
git clone --bare <repo-url> ~/dotfiles
dot config --local status.showUntrackedFiles no

dot checkout

ln -s ~/.nixos/ /etc/nixos # on NixOS
```

If you are not using NixOS, additional configuration may be required. If anything behaves incorrectly, read over the [.nixos](.nixos/) configuration files and run equivalent commands manually.

## Inspiration

- <https://youtu.be/tBoLDpTWVOM>
- <https://www.atlassian.com/git/tutorials/dotfiles>
