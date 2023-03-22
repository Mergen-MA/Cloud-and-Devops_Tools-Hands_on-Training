# Meta Arguments

# create_before_destroy can help with zero downtime deployments

resource "aws_instance" "server" {
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
    ignore_changes = [    # prevents terraform trying to revert metadata being else elsewhere
      # some resources have metadata
      # modified automatically outside of terraform
      tags
    ]
    prevent_destroy = true # causes terraform to reject any plan which would destroy this resource.

    depends_on  : if two resources depends on each other (but not each other's data) depends_on specifies that dependency to enforce ordering

  }
}

# Provisioner
 # perform action on local or remote machine
 # get the examples from about terraform language page

file
local-exec
remote-exec
vendor
  chef
  puppet




Potential Gotchas


Name changes when refactoring
	If you change a name of resource within your terraform config it can lead terraform to think oh they want delete this resource create a new one. You have to be careful renaming your resources.  Sometimes that might what you want but sometimes not.


Sensitive data in Terraform state files
	State files includes sensitive data within them. Be careful and sure to encrypt them manage permissions accordingly.

Cloud timeouts
	you can isssue a command sometimes it takes more you expect that server to provision the resources. Terraform have spmetimes timeouts. You have to reissue your command will fix that.


Forgetting to destroy test-intra
	Make sure to apply destroy command or cleanup periodically to avoid surprise bills
Uni-directional version upgrades
	Terraform has uni-directional version upgrades. By that I mean if I run terraform version 1.0.0 to provision my infrastructure and my colleague runs terraform 1.1.0 I can now no longer issue a command with with my older version of terraform because state files is associated with the new version. I need to upgrade. If you work with a large team make sure everyone uses the same version of terraform on their local system as well as matching that version in your CI/CD system.

Multiple ways to accomplish same configuration
	There are always ways to achieve the things. What would be cleanest way to achieve particular issue.

some Params are immutable
	There are certains fields within a resource that i can't change. Refer the documentation prevent you getting errors.

Sensitive data

terraform apply -var="db_username=myusername" -var="db_password=mypassword"

variable "db_username" {
  description = "username for database"
  type = string
  default = "egien"
}


variable "db_password" {
  description = "password for database"
  type = string
  sensitive = true   # by adding sensitive attribute, when you run terraform apply it would echo that out into the terminal
}

Managing Multiple Environments

	Workspaces

	