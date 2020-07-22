
### Create the VPC for our Redis Cache Cluster ###

resource "aws_vpc" "caching-vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  instance_tenancy = "default"

  tags = {
    Name = var.caching-vpc-tag
  }
}


### Create Internet Gateway for our VPC ###

resource "aws_internet_gateway" "caching-igw" {
  vpc_id = aws_vpc.caching-vpc.id
  
  tags = {
    Name = "rediscache-igw"
  }
}


### Create a Route Table to be used by our Internet Gateway ###

resource "aws_route_table" "caching-rtb" {
  vpc_id = aws_vpc.caching-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.caching-igw.id
  }

  tags = {
    Name = "rediscache-rtb"
  }
}


### Create 2 Subnets to make up the Subnet Group to launch our Cluster in ###

##  Subnet A
##  ========
resource "aws_subnet" "caching-subneta" {
  vpc_id            = aws_vpc.caching-vpc.id
  cidr_block        = var.subneta_cidr_block
  availability_zone = var.zone-a
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.caching-sub-tag-a
  }
}

##  Subnet B
##  ========
resource "aws_subnet" "caching-subnetb" {
  vpc_id = aws_vpc.caching-vpc.id
  cidr_block = var.subnetb_cidr_block
  availability_zone = var.zone-b
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.caching-sub-tag-b
  }
}

### Create 2 additional Subnets: 1 to launch an EC2 instance into for our Redis Server and 1 for Jenkins server (for our pipeline) ###

##  Subnet C
##  ========
resource "aws_subnet" "caching-subnetc" {
  vpc_id            = aws_vpc.caching-vpc.id
  cidr_block        = var.subnetc_cidr_block
  availability_zone = var.zone-c
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.caching-sub-tag-c
  }
}

##  Subnet D
##  ========
resource "aws_subnet" "caching-subnetd" {
  vpc_id = aws_vpc.caching-vpc.id
  cidr_block = var.subnetd_cidr_block
  availability_zone = var.zone-b
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.caching-sub-tag-d
  }
}

### Associate a Route Table to our Subnets ###

resource "aws_route_table_association" "caching-rtbassa" {
  subnet_id      = aws_subnet.caching-subneta.id
  route_table_id = aws_route_table.caching-rtb.id
}

resource "aws_route_table_association" "caching-rtbassb" {
  subnet_id      = aws_subnet.caching-subnetb.id
  route_table_id = aws_route_table.caching-rtb.id
}

resource "aws_route_table_association" "caching-rtbassc" {
  subnet_id      = aws_subnet.caching-subnetc.id
  route_table_id = aws_route_table.caching-rtb.id
}

resource "aws_route_table_association" "caching-rtbassd" {
  subnet_id      = aws_subnet.caching-subnetd.id
  route_table_id = aws_route_table.caching-rtb.id
}

### Assign Subnets A and B to our Redis Cluster's Subnet Group ###

resource "aws_elasticache_subnet_group" "rediscluster-subgrp" {
  name       = "caching-subgrp"
  subnet_ids = ["${aws_subnet.caching-subneta.id}", "${aws_subnet.caching-subnetb.id}"]
}


### Create the Security Group to attach to our elasticache replication group

resource "aws_security_group" "repgrp-secgrp" {
  name = var.caching-cluster-secgrp
  vpc_id = aws_vpc.caching-vpc.id

  tags = {
    Name = "rediscluster-sg"
  }

###  ALL INBOUND

# Redis port
  ingress {
    from_port         = 6379
    to_port           = 6379
    protocol          = "tcp"
    cidr_blocks       = ["172.31.12.0/24"]
    description = "traffic allowed from sources within the network ONLY"
  }

###  ALL OUTBOUND 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow traffic to all destinations"
  }
}


### Create the Security Group to attach to our Redis server

resource "aws_security_group" "rediserver-secgrp" {
  name = "rediserver-sg"
  vpc_id = aws_vpc.caching-vpc.id

  tags = {
    Name = "rediserver-sg"
    
  }

###  ALL INBOUND

# Redis port
  ingress {
    from_port         = 6379
    to_port           = 6379
    protocol          = "tcp"
    cidr_blocks       = ["172.31.12.0/24"]
    description = "traffic allowed from sources within the network ONLY"
  }
# Swagger webUI port
  ingress {
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    description = "traffic allowed from all sources"
  }
# SSH port
  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    description = "traffic allowed from all sources"
  }


###  ALL OUTBOUND 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow traffic to all destinations"
  }
}


### Create the Security Group to attach to our Jenkins server

resource "aws_security_group" "jenkinserver-secgrp" {
  name = "jenkins-sg"
  vpc_id = aws_vpc.caching-vpc.id

  tags = {
    Name = "redis-jenkins-sg"
    
  }

###  ALL INBOUND

# SSH port
  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    description = "traffic allowed from all sources"
  }

# Jenkins webUI port
  ingress {
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    description = "traffic allowed from all sources"
  }


###  ALL OUTBOUND 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow traffic to all destinations"
  }
}

