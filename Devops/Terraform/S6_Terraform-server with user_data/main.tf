terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


locals {
  mytag = "mali-tf-ins"
}

data "aws_ami" "tf-ami" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "tf-ec2" {
  ami                    = data.aws_ami.tf-ami.id
  instance_type          = var.ec2_type
  key_name                = "devops13"
  vpc_security_group_ids = [aws_security_group.mali-secgrp-tf.id]
  tags = {
    Name = "${local.mytag}-ami"
  }

  user_data = <<-EOF
        #! /bin/bash
        yum update -y
        sudo yum install -y yum-utils shadow-utils
        sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
        sudo yum -y install terraform
        EOF
}
resource "aws_security_group" "mali-secgrp-tf" {
  name        = "mali-secgrp-tf"
  description = "SSH & HTTP"

  ingress {
    description = "allow inbound with ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow inbound with HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.mytag}-secgrp"
  }


}