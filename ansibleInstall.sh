#This file bootstraps Ansible, PHP, GIT and Python on the Instances
#!/bin/bash


# Install ansible 
# If ansible is in the sources list on linux server
if ! grep -q "ansible/ansible" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo apt-add-repository ppa:ansible/ansible -y # Add ppa to repository
fi
# If not, install ansible
if ! hash ansible >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install software-properties-common ansible git python-apt -y
fi
# Clone git repository that contains php index.html for website
git clone https://github.com/aki23gup/Ansible-LAMP-Stack.git
cd Ansible-Lamp-Stack && ansible-playbook components.yaml #run ansible playbook that configures php on ec2