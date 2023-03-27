#! /bin/bash
sudo yum update -y
sudo install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
newgrp docker
docker version
sudo systemctl status docker