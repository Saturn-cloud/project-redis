### Create the Parameter Group for our ElastiCache Cluster for Redis

resource "aws_elasticache_parameter_group" "rediscluster-paramgrp" {
  name   = var.caching-paramgrp-nm
  family = var.caching-paramgrp-fam

  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }
}

### Create our ElastiCache Cluster for Redis version 5.0.6
### Note the Configuration Endpoint Address created

resource "aws_elasticache_replication_group" "rediscluster-repgrp" {
  replication_group_id          = var.caching-repgrp-id
  replication_group_description = var.caching-repgrp-desc
  node_type                     = var.cluster-node-type
  port                          = var.caching-port
  parameter_group_name          = aws_elasticache_parameter_group.rediscluster-paramgrp.name
  automatic_failover_enabled    = true
  engine			= var.caching-engine
  engine_version		= var.caching-redis-ver
  subnet_group_name		= aws_elasticache_subnet_group.rediscluster-subgrp.name
  security_group_ids		= ["${aws_security_group.repgrp-secgrp.id}"]
  //security_group_names	= ["${aws_security_group.repgrp-secgrp.name}"] optional in place of ids

  cluster_mode {
    replicas_per_node_group     = var.caching-repper-nodegrp   // this is the replica mentioned below
    num_node_groups             = var.caching-node-num       // 2 shards of which each shard has 1 replica above 
  }
}

