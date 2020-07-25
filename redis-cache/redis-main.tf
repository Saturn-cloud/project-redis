
# create an AWS EC2 instance in Subnet-c to be used for Redis server using 
# the Packer image created from the rediserver-ami.json template file

resource "aws_instance" "redis-node" {
  ami                    = data.aws_ami.redis_packer_image.id
  instance_type          = var.instance-type
  key_name               = var.key-name
  subnet_id              = aws_subnet.caching-subnetc.id
  vpc_security_group_ids = ["${aws_security_group.rediserver-secgrp.id}"]
  count                  = var.instance-count
  
  tags = {
    Name = var.redis-instance-tag
  }
}
# lookup the Packer image to be used for the Redis server
data "aws_ami" "redis_packer_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["redis-server-ami"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["self"]
}
output "rediserver_ip_address" {
  value = aws_instance.redis-node.*.public_ip
}
