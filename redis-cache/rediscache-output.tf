/*
output "endpoint" {
  value       = aws_elasticache_cluster.rediscluster_cache.*.primary_endpoint_address
  description = "Redis primary endpoint"
}


output "configuration_endpoint_address" {
  value = "${aws_elasticache_replication_group.default.configuration_endpoint_address}"
}


output "host" {
  value       = module.dns.hostname
  description = "Redis hostname"
}
*/