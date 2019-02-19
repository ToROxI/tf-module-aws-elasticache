output "cache_nodes" {
  description = "List of node objects including id, address, port and availability_zone. "
  value       = "${aws_elasticache_cluster.redis-with-subnet-group-and-security-group.cache_nodes}"
}
