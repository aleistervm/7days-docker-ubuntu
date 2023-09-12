# Here is basic configuration for an Ubuntu 22.04 server.
# 1. Install docker
# 2. Setup a swap file

# Update package index
sudo apt update

# If you want to install any upgrades
# sudo apt upgrade


# ----- INSTALL DOCKER -----
# https://docs.docker.com/engine/install/ubuntu/

# Install required dependencies for adding repositories:
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings

# Add the Docker GPG key to ensure the authenticity of the Docker package
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the Docker repository to your system
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again
sudo apt update

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start the docker service:
sudo systemctl enable docker
sudo systemctl start docker

# Verify docker is installed and running
sudo docker --version


# ----- SETUP AN 8 GB SWAP FILE -----

# Setup an 8GB swap file (minimum required by 7 Days to Die)
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Make the swapfile permanent
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Adjust swappiness and cache pressure
sudo sysctl vm.swappiness=10
sudo sysctl vm.vfs_cache_pressure=50

# Add these lines to the bottom of /etc/sysctl.conf
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf


# ----- GIT - PULL PROJECT FILES -----

# Clone the repository
git clone https://github.com/aleistervm/7days-docker-ubuntu.git


# ----- LAST STEP -----

# Reboot the system
sudo reboot