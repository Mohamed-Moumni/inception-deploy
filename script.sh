#!/bin/sh

# Installation of Aws CLI

curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "/tmp/awscliv2.zip"

unzip /tmp/awscliv2.zip

./aws/install

# install Ansible

sudo apt install software-properties-common -y

sudo add-apt-repository --yes --update ppa:ansible/ansible

sudo apt install ansible -y

# install ansible aws community collectoins

ansible-galaxy collection install amazon.aws

# run the playbook

ansible-playbook -i inventory.ini main.yml --vault-password-file ./.vault_pass