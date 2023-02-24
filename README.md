# dotfiles

A repository of my dotfiles

## Creating this Repository

To create a similar _dotfiles_ repository, add the following to your shell config:

```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Then, run the following commands:

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

To clone these dotfiles to your machine, add the following to your shell config:

```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Then, run the following commands:

```bash
git clone --bare <repo-url> ~/dotfiles
config config --local status.showUntrackedFiles no

config checkout
```

As this repository exclusively contains handwritten dotfiles, additional configuration is required to get everything working properly. The [Dockerfile](./.docker/Dockerfile) fetches this repository and builds a container with this configuration from an Ubuntu image. Standalone [installation scripts](./.docker) that temporarily change the keyboard layout to Dvorak, remap the Caps Lock key to Escape, build the container, and mount the filesystem onto it are available for a few common operating systems.

## Inspiration

- <https://youtu.be/tBoLDpTWVOM>
- <https://www.atlassian.com/git/tutorials/dotfiles>
