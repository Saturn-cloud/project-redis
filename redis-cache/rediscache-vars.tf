
######################### Variables applicable to all our cloud infrastructure #########################

variable "vpc_cidr_block" {
 type = string
  default = "172.31.12.0/24"
}

variable "zone-a" {
 type = string
 default = "eu-west-2a"
}

variable "zone-b" {
 type = string
 default = "eu-west-2b"
}

variable "zone-c" {
 type = string
 default = "eu-west-2c"
}

variable "subneta_cidr_block" {
 type = string
  default = "172.31.12.10/26"
}

variable "subnetb_cidr_block" {
 type = string
  default = "172.31.12.68/26"
}

variable "subnetc_cidr_block" {
 type = string
  default = "172.31.12.133/26"
}

variable "subnetd_cidr_block" {
 type = string
  default = "172.31.12.245/26"
}

variable "caching-vpc-tag" {
 type = string
 default = "vpc-rediscache"
}

variable "caching-sub-tag-a" {
 type = string
 default = "subneta-rediscache"
}

variable "caching-sub-tag-b" {
 type = string
 default = "subnetb-rediscache"
}

variable "caching-sub-tag-c" {
 type = string
 default = "subnetc-rediscache"
}

variable "caching-sub-tag-d" {
 type = string
 default = "subnetd-rediscache"
}

variable "caching-cluster-secgrp" {
 type = string
 default = "cluster-sec-grp"
}

variable "caching-sec-grp" {
 type = string
 default = "rediscache-security-grp"
}

/*
variable "caching-cluster-id" {
 type = string
 default = "saturn-rediscache"
}
*/

variable "caching-paramgrp-nm" {
 type = string
 default = "saturn-pg"
}

variable "caching-paramgrp-fam" {
 type = string
 default = "redis5.0"
}

variable "caching-repgrp-id" {
 type = string
 default = "rediscluster-repgrp" 
}

variable "caching-repgrp-desc" {
 type = string
 default = "Rediscahce-replication-group"
}

variable "cluster-node-type" {
 type = string
 default = "cache.t2.micro"
}

variable "num-cache-node" {
 type = string
 default = "1"
}

variable "caching-port" {
 type = string
 default = "6379"
}

variable "caching-cluster-zones" {
 type = list
 default = ["eu-west-2a", "eu-west-2b"]
}
variable "caching-engine" {
 type = string
 default = "redis"
}

variable "caching-redis-ver" {
 type = string
 default = "5.0.6"
}

variable "redis-port" {
 type = string
 default = "6379"
 
variable "caching-repper-nodegrp" {
 type = string
 default = "1"
}

variable "caching-node-num" {
 type = string
 default = "1"
}


######################### Variables applicable to only the Jenkins and Redis server nodes #########################

variable "region" {
 type = string
  default = "eu-west-2"
}

variable "key-name" {
 type = string
 default = "first_keys"
}

variable "instance-type" {
 type = string
 default = "t2.micro"
}

variable "instance-count" {
 type = string
 default = "1"
}

variable "jnks-instance-tag" {
 type = string
 default = "redis-jenkins"
}

variable "redis-instance-tag" {
 type = string
 default = "redis-server"
}

