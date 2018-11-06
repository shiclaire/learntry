
#!/usr/bin/env bash

sudo amazon-linux-extras install -y ansible2
sudo yum install -y python python-dev python-pip
sudo pip install boto
sudo pip install boto3
export ANSIBLE_HOST_KEY_CHECKING=False
sudo nano /etc/ansible/ansible.cfg