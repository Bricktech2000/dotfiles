# note: this file is standalone and doesn't require any context from this repository
#       it fetches github.com/Bricktech2000/dotfiles and builds the image from there

FROM ubuntu

RUN apt-get update
RUN apt-get install -y software-properties-common curl
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y git neovim python3 python3-pip nodejs

# dotfiles
RUN git clone --bare https://github.com/Bricktech2000/dotfiles.git ~/dotfiles
RUN git --git-dir=$HOME/dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
RUN git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout

# tmux
RUN apt-get install -y tmux

# fish
RUN add-apt-repository ppa:fish-shell/release-3
RUN apt-get install -y exa fish ripgrep
RUN curl -sL https://get.oh-my.fish > install_omf && fish install_omf --noninteractive && fish -c "omf install bobthefish" && rm install_omf
RUN fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
RUN fish -c "echo y | fish_config theme save 'Mono Smoke'"
RUN pip3 install thefuck
RUN chsh -s /usr/bin/fish

# nvm
RUN fish -c "fisher install edc/bass"
RUN curl -sLo- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN fish -c "nvm install node"

# neovim
RUN add-apt-repository ppa:ethereum/ethereum
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install -y latexmk solc clangd pylint
RUN fish -c "npm install --global --save-dev prettier prettier-plugin-solidity" && pip3 install neovim
RUN curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN echo "\n\nThe error below is expected and can safely be ignored.\n" && nvim +'PlugInstall --sync' +qa
RUN nvim +':CocInstall -sync coc-markdownlint coc-clangd coc-rust-analyzer coc-prettier coc-solidity coc-pyright coc-snippets coc-tsserver coc-eslint coc-tslint coc-css coc-lists coc-highlight coc-json' +qa
