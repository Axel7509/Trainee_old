#!/bin/bash

os=$(uname -s)

if [ "$os" == "Linux" ]; then
  if [ -f "/etc/redhat-release" ]; then
    # Установка на Red Hat и CentOS
    sudo yum install -y python3 python3-pip
  elif [ -f "/etc/lsb-release" ]; then
    # Установка на Ubuntu
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
  fi
elif [ "$os" == "Darwin" ]; then
  # Установка на macOS (используя Homebrew)
  brew install python3
fi

pip3 install awscli --upgrade --user

aws configure
