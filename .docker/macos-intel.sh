echo "Installing Docker..."
curl -L https://desktop.docker.com/mac/main/amd64/Docker.dmg -o Docker.dmg
sudo hdiutil attach Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
sudo hdiutil detach /Volumes/Docker
rm Docker.dmg
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew install --cask docker

# TODO set keyboard layout
curl -sL https://github.com/Bricktech2000/dotfiles/raw/master/.docker/Dockerfile | \
sudo docker build -t dotfiles -
sudo docker run -it -v /:/mnt dotfiles fish -C "cd '/mnt/$(pwd)/'"

sudo docker rmi -f dotfiles
sudo docker system prune -f
echo -n "Press any key to reset keyboard layout..." && read -n 1 -s
# TODO reset keyboard layout
