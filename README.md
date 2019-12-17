# tf-module-aws-elasticache

Terraform module to setup Elasticache

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cache\_engine | Cache engine selector (only redis is available for now) | string | `redis` | no |
| cluster\_name | Cache cluster name | string | `example-cluster` | no |
| cluster\_port | The port number on which each of the cache nodes will accept connections | string | `6379` | no |
| engine\_version | Version number of the cache engine to be used | string | `3.2.10` | no |
| module\_enabled | Switch to enable/disable module | string | `true` | no |
| node\_type | AWS Node type | string | `cache.m4.large` | no |
| parameter\_group\_name | Name of the parameter group to associate with this cache cluster | string | `default.redis3.2` | no |
| security\_group\_ids | List of VPC Security Group IDs for the cache cluster | list | `<list>` | no |
| subnet\_ids | List of VPC Subnet IDs for the cache subnet group | list | `<list>` | no |
| tags | description | map | `<map>` | no |
| availability\_zones | List of AZ | list | `<list>` | no |
| replication\_enabled | Switch to enable/disable replica | string | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| cache\_nodes | List of node objects including id, address, port and availability_zone. |
