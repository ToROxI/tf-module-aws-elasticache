variable "module_enabled" {
  description = "Switch to enable/disable module"
  default     = "true"
}

variable "cluster_name" {
  description = "Cache cluster name"
  default     = "example-cluster"
}

variable "cache_engine" {
  description = "Cache engine selector (only redis is available for now)"
  default     = "redis"
}

variable "node_type" {
  description = "AWS Node type"
  default     = "cache.m4.large"
}

variable "parameter_group_name" {
  description = "Name of the parameter group to associate with this cache cluster"
  default     = "default.redis3.2"
}

variable "engine_version" {
  description = "Version number of the cache engine to be used"
  default     = "3.2.10"
}

variable "cluster_port" {
  description = "The port number on which each of the cache nodes will accept connections"
  default     = 6379
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the cache subnet group"
  default     = []
}

variable "security_group_ids" {
  description = "List of VPC Security Group IDs for the cache cluster"
  default     = []
}

variable "tags" {
  description = "description"

  default = {
    Project     = "project"
    Environment = "test"
  }
}
