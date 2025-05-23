# dotfiles

_A repository of my dotfiles_

## Installation

To install these dotfiles to your machine, add the following to your shell config:

```sh
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Then, run the following commands:

```sh
git clone --bare <repo-url> ~/dotfiles
dot config --local status.showUntrackedFiles no

dot checkout

ln -s ~/.nixos/ /etc/nixos # if on NixOS
```

If you are not using NixOS, additional configuration may be required. If anything behaves incorrectly, read over the [.nixos](.nixos/) configuration files and run equivalent commands manually.

## From-Scratch Setup

To manage your dotfiles using a bare repository like this one, add the following to your shell config:

```sh
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Then, run the following commands:

```sh
git init --bare ~/dotfiles
echo "dotfiles" >> ~/.gitignore
dot config --local status.showUntrackedFiles no

dot add .gitignore
dot commit -m "initial commit"
dot remote add origin <repo-url>
dot push -u origin master

mv /etc/nixos/ ~/.nixos # if on NixOS
ln -s ~/.nixos/ /etc/nixos # if on NixOS
```
