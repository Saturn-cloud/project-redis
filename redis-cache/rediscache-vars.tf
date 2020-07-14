variable "region" {
 type = string
  default = "eu-west-2"
}

variable "vpc_cidr_block" {
 type = string
  default = "172.31.12.0/24"
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

variable "caching-cluster-id" {
 type = string
 default = "saturn-rediscache"
}

variable "cluster-node-type" {
 type = string
 default = "cache.t2.micro"
}

variable "num-cache-node" {
 type = string
 default = "1"
}

variable "redis-engine-version" {
 type = string
 default = "5.0.6"
}

variable "redis-port" {
 type = string
 default = "6379"
 
}

