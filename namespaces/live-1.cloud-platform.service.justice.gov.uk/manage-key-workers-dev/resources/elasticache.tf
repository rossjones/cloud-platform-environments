variable "cluster_name" {
}


module "dps_redis" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-elasticache-cluster?ref=5.3"
  cluster_name           = var.cluster_name
  application            = var.application
  environment-name       = var.environment-name
  is-production          = var.is-production
  infrastructure-support = var.infrastructure-support
  team_name              = var.team_name
  number_cache_clusters  = var.number_cache_clusters
  node_type              = var.node-type
  engine_version         = "4.0.10"
  parameter_group_name   = "default.redis4.0"
  namespace              = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "dps_redis" {
  metadata {
    name      = "dps-redis"
    namespace = var.namespace
  }

  data = {
    REDIS_HOST      = module.dps_redis.primary_endpoint_address
    REDIS_PASSWORD  = module.dps_redis.auth_token
    member_clusters = jsonencode(module.dps_redis.member_clusters)
  }
}
