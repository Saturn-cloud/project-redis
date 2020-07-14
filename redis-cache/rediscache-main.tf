### Create the Parameter Group for our ElastiCache Cluster for Redis

resource "aws_elasticache_parameter_group" "rediscluster-paramgrp" {
  name   = "saturn-rediscluster-pg"
  family = "redis5.0"
}

### Create our ElastiCache Cluster for Redis

resource "aws_elasticache_cluster" "rediscluster-cache" {
  cluster_id           = var.caching-cluster-id
  engine               = "redis"
  node_type            = var.cluster-node-type
  num_cache_nodes      = var.num-cache-node
  parameter_group_name = aws_elasticache_parameter_group.rediscluster-paramgrp.name 
  engine_version       = var.redis-engine-version
  port                 = var.redis-port
  subnet_group_name    = aws_elasticache_subnet_group.rediscluster-subgrp.name
 // security_group_ids   = ["${aws_elasticache_security_group.rediscache-secgrp.id}"]

}
