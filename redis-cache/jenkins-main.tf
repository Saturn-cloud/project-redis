# create an AWS EC2 instance in Subnet-d to be used for Jenkins box using 
# the Packer image created from the "jenkins-ami.json" template file

resource "aws_instance" "jenkins-node" {
  ami                    = data.aws_ami.jnks_packer_image.id
  instance_type          = var.instance-type
  key_name               = var.key-name
  subnet_id              =  aws_subnet.caching-subnetd.id
  vpc_security_group_ids = ["${aws_security_group.jenkinserver-secgrp.id}"]
  count                  = var.instance-count
  
  tags = {
    Name = var.jnks-instance-tag
  }
}
# lookup the Packer image to be used for the Jenkins box
data "aws_ami" "jnks_packer_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["redis-jenkins-ami"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["self"]
}
output "Jenkins_ip_address" {
  value = aws_instance.jenkins-node.*.public_ip
}
