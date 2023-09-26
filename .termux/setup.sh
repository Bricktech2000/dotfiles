# general

mkdir ~/bin && ln -s ~/.termux/termux-file-editor ~/bin/termux-file-editor

# storage

termux-setup-storage
ln -s /storage/emulated/0/Sync ~/Sync

# font

curl -sL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip -o FiraCode.zip
unzip FiraCode.zip FiraCodeNerdFont-Regular.ttf -d ~/.termux
mv ~/.termux/FiraCodeNerdFont-Regular.ttf ~/.termux/font.ttf
rm FiraCode.zip
