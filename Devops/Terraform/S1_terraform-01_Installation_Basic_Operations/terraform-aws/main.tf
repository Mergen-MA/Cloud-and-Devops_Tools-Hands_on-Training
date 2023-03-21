terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.59.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "europe"
  region = "eu-central-1"
  
}

locals {
  mytags = {
    "Name1" = "us-east-ec2"
    "Name2" = "eu-central-ec2"

  }
}

data "aws_ami" "tf-ami" {
    most_recent = true
    owners  = ["self"]

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }   
  
}

resource "aws_instance" "terraform_usa" {
    ami = data.aws_ami.tf_ami.id
    #ami = var.ami_num
    instance_type = var.ins_type  
    key_name = "devops13"
    security_groups = ["tf-sec-grp-usa"]
    tags = {
        Name = "${local.Name1}-tf-my-ami"
    }

    provisioner "local-exec" {
        command = "echo http://${self.public_ip} > public_ip.txt"
    }

    connection {
      host = self.public_ip
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/devops13.pem")
    }

    provisioner "remote-exec" {
        inline = [
          "sudo yum update -y",
          "sudo systemctl install httpd",
          "sudo systemctl start httpd"
        ]
    }

    provisioner "file" {
        content = self.public_ip
        destination = "/home/ec2-user/my_public_ip.txt"
      
    }
}

resource "aws_security_group" "sc-grp-usa" {
  description = "Allow SSH-HTTP-HTTPS"
  name = "tf-sec-grp-usa"
  tags = {
    "Name" = "tf-provisioner-sg"
  }

  ingress =  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "provisioner-inbound"
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }
  
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress =  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "provisioner outbound"
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
  
}

