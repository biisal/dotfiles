#!/bin/bash

# Ask password via sudo
echo "Enter password to continue:"
if sudo -v; then
    echo "Access granted."
else
    echo "Access denied."
    sleep 2
    exit 1
fi

# Then run the actual shell (Zsh)
exec /bin/zsh

