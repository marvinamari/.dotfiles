#!/bin/sh
# https://medium.com/@ls12styler/docker-as-an-integrated-development-environment-95bc9b01d2c1
# Git config

# Set Git user credentials
if [ ! -z "$GIT_USER_NAME" ] && [ ! -z "$GIT_USER_EMAIL" ]; then
    git config --global user.name "$GIT_USER_NAME"
    git config --global user.email "$GIT_USER_EMAIL"
fi

exec /bin/bash
