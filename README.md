# Devops_Path_Hands-on
AWS and Devops Hands-on 

Terraform installation commands
- Connect to your instance with SSH.

```bash
ssh -i .ssh/call-training.pem ec2-user@ec2-3-133-106-98.us-east-2.compute.amazonaws.com
```

- Update the installed packages and package cache on your instance.

```bash
sudo yum update -y
```

- Install yum-config-manager to manage your repositories.

```bash
sudo yum install -y yum-utils
```
- Use yum-config-manager to add the official HashiCorp Linux repository to the directory of /etc/yum.repos.d.

```bash
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
```

- Install Terraform.

```bash
sudo yum -y install terraform
```

- Verify that the installation

```bash
terraform version
