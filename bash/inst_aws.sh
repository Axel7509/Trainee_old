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
elif [[ "$os" == "MINGW"* ]]; then
  # Установка на Windows (используя msiexec)
  curl "https://awscli.amazonaws.com/AWSCLIV2.msi" -o "AWSCLIV2.msi"
  msiexec.exe /i "AWSCLIV2.msi" /quiet
  rm "AWSCLIV2.msi"
fi

pip3 install awscli --upgrade --user

aws configure
