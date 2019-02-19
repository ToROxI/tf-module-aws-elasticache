output "cache_nodes" {
  description = "List of node objects including id, address, port and availability_zone. "
  value       = "${element(concat(aws_elasticache_cluster.redis-with-subnet-group-and-security-group.*.cache_nodes, list("")), 0)}"
}
