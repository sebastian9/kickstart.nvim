#!/bin/bash

# Check if both username and container ID are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <container_name>"
    exit 1
fi

USERNAME=$1
CONTAINER_NAME=$2

# Check if the container exists and is running
if ! docker ps -q --filter "name=$CONTAINER_NAME" | grep -q .; then
    echo "Container $CONTAINER_NAME is not running or does not exist."
    exit 1
fi

# Check if the user exists in the container
if ! docker exec $CONTAINER_NAME id -u $USERNAME >/dev/null 2>&1; then
    echo "User $USERNAME does not exist in the container."
    exit 1
fi

# Copy Neovim configuration
echo "Copying Neovim configuration..."
docker cp ~/.config/nvim $CONTAINER_NAME:/home/$USERNAME/.config/nvim
docker cp ~/.config/github-copilot $CONTAINER_NAME:/home/$USERNAME/.config/github-copilot

# Set correct ownership for the copied files
docker exec $CONTAINER_NAME sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.config

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Neovim installation and configuration complete."
else
    echo "Failed to copy Neovim configuration."
    exit 1
fi
