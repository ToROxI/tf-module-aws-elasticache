locals {
  cluster_name = "${var.cluster_name}"
  cluster_mode = "${ var.cluster_mode_enabled ? ".cluster.on" : "" }"
  default_tags = {}
}

resource "aws_elasticache_subnet_group" "this" {
  #   count = "${ var.module_enabled && "${length(var.subnet_ids)}" > 0 ? 1 : 0 }"

  count       = "${ var.module_enabled ? 1 : 0 }"
  name        = "${local.cluster_name}"
  description = "Subnet Group for ${local.cluster_name}"
  subnet_ids  = ["${var.subnet_ids}"]
}

resource "aws_elasticache_cluster" "redis-with-subnet-group-and-security-group" {
  #   count = "${ var.module_enabled && "${lower(var.cache_engine)}" == "redis" && "${length(var.subnet_ids)}" > 0 && "${length(var.security_group_ids)}" > 0 ? 1 : 0 }"

  count = "${var.module_enabled && var.replication_enabled ? 0 : 1}"
  cluster_id           = "${local.cluster_name}"
  engine               = "redis"
  node_type            = "${var.node_type}"
  num_cache_nodes      = 1
  parameter_group_name = "${var.parameter_group_name}${local.cluster_mode}"
  engine_version       = "${var.engine_version}"
  port                 = "${var.cluster_port}"

  subnet_group_name = "${aws_elasticache_subnet_group.this.0.name}"

  security_group_ids = ["${var.security_group_ids}"]

  tags = "${merge(local.default_tags, var.tags)}"
}

# resource "aws_elasticache_cluster" "redis" {
#   count                = "${ lower(var.cache_engine) == "redis" && length(var.subnet_ids) == 0 && length(var.security_group_ids) == 0 ? 1 : 0 }"
#   cluster_id           = "${local.cluster_name}"
#   engine               = "redis"
#   node_type            = "${var.node_type}"
#   num_cache_nodes      = 1
#   parameter_group_name = "${var.parameter_group_name}"
#   engine_version       = "${var.engine_version}"
#   port                 = "${var.cluster_port}"


#   tags = "${merge(local.default_tags, var.tags)}"
# }

resource "aws_elasticache_replication_group" "replication_group" {
  count = "${var.module_enabled && var.replication_enabled ? 1 : 0}"
  automatic_failover_enabled    = true
  availability_zones            = ["${var.availability_zones}"]
  engine_version                = "${var.engine_version}"
  replication_group_id          = "${local.cluster_name}"
  replication_group_description = "APAC TF test"
  node_type                     = "${var.node_type}"
  number_cache_clusters         = "2"
  parameter_group_name          = "${var.parameter_group_name}"
  port                          = "${var.cluster_port}"
  lifecycle {
  ignore_changes = ["number_cache_clusters"]
}
  subnet_group_name = "${aws_elasticache_subnet_group.this.0.name}"
  security_group_ids = ["${var.security_group_ids}"]
  tags = "${merge(local.default_tags, var.tags)}"
}

resource "aws_elasticache_cluster" "replica" {
  count = "${var.module_enabled && var.replication_enabled ? 1 : 0}"
  cluster_id           = "${local.cluster_name}-${count.index}"
  replication_group_id = "${aws_elasticache_replication_group.replication_group.id}"
}
