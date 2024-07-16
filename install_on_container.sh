#!/bin/bash

# Check if both username and container ID are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <container_id>"
    exit 1
fi

USERNAME=$1
CONTAINER_ID=$2

# Check if the container exists and is running
if ! docker ps -q -f id=$CONTAINER_ID | grep -q .; then
    echo "Container $CONTAINER_ID is not running or does not exist."
    exit 1
fi

# Check if the user exists in the container
if ! docker exec $CONTAINER_ID id -u $USERNAME >/dev/null 2>&1; then
    echo "User $USERNAME does not exist in the container."
    exit 1
fi

# Install Neovim in the container from source
echo "Installing Neovim in container $CONTAINER_ID..."
docker exec $CONTAINER_ID sudo -u $USERNAME bash -c 'sudo apt-get update && sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential && cd ~ && git clone https://github.com/neovim/neovim && cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install'

# Check if Neovim was installed successfully
if [ $? -ne 0 ]; then
    echo "Failed to install Neovim. Exiting."
    exit 1
fi

# Copy Neovim configuration
echo "Copying Neovim configuration..."
docker cp ~/.config/nvim $CONTAINER_ID:/home/$USERNAME/.config/nvim

# Set correct ownership for the copied files
docker exec $CONTAINER_ID sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.config/nvim

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Neovim installation and configuration complete."
else
    echo "Failed to copy Neovim configuration."
    exit 1
fi
