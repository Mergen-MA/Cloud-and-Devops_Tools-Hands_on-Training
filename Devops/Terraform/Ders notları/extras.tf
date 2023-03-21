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