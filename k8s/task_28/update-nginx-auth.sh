#!/bin/bash

login=$(aws ssm get-parameter --name "/myapp/nginx-username"  --query "Parameter.Value" --output text)
password=$(aws ssm get-parameter --name "/myapp/nginx-password"  --with-decryption --query "Parameter.Value" --output text)

# Generate the password in the correct format
encrypted_password=$(openssl passwd -apr1 "$password")

# Write login and password to the .htpasswd file
sudo sh -c "echo -n '$login:' >> /etc/nginx/.htpasswd"
sudo sh -c "echo '$encrypted_password' >> /etc/nginx/.htpasswd"