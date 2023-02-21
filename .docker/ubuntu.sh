echo "Installing Docker..."
sudo apt-get update
sudo apt-get install -y docker.io

xset r rate 100 50
setxkbmap dvorak
setxkbmap -option "caps:swapescape"
curl -sL https://github.com/Bricktech2000/dotfiles/raw/master/.docker/Dockerfile | \
sudo docker build -t dotfiles -
sudo docker run -it -v /:/mnt dotfiles fish -C "cd '/mnt/$(pwd)/'"

sudo docker rmi -f dotfiles
sudo docker system prune -f
echo -n "Press any key to reset keyboard layout..." && read -n 1 -s
setxkbmap -option ""
setxkbmap us
xset r rate
