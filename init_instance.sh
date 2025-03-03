#!/bin/bash

# Cập nhật hệ thống
sudo apt update && sudo apt upgrade -y
# echo "openssh-server openssh-server/sshd_config select true" | sudo debconf-set-selections
# sudo DEBIAN_FRONTEND=noninteractive apt-get install -y unattended-upgrades
# sudo dpkg-reconfigure --frontend=noninteractive unattended-upgrades
# sudo apt upgrade -y

# # Cài đặt kernel mới nhất
# sudo apt install -y linux-generic

# Cài đặt các tiện ích cần thiết
sudo apt install -y curl wget git zsh

# Cài đặt Docker
sudo apt install -y apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce

# Thêm người dùng hiện tại vào nhóm Docker
sudo usermod -aG docker $USER

# Cài đặt Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# # Cài đặt Nginx
# sudo apt install -y nginx

# # Cài đặt Certbot
# sudo snap install core; sudo snap refresh core
# sudo snap install --classic certbot
# sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Cài đặt Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Cài đặt plugin zsh cho Git, Docker, docker-compose
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Cấu hình .zshrc để sử dụng plugins
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting docker docker-compose)/' ~/.zshrc

# Đặt Zsh làm shell mặc định
chsh -s $(which zsh)

# Cài đặt NodeJS phiên bản mới nhất sử dụng nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node # Cài đặt phiên bản mới nhất của Node.js
nvm use node

# Hiển thị phiên bản của các phần mềm đã cài đặt
echo "NodeJS version:"
node -v
echo "NPM version:"
npm -v
echo "Docker version:"
docker --version
echo "Docker Compose version:"
docker-compose --version
# echo "Nginx version:"
# nginx -v
# echo "Certbot version:"
# certbot --version
echo "Git version:"
git --version

# Reboot after 30s
sleep 30
reboot
