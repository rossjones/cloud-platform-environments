module "hmpps_manage_adjudications" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-elasticache-cluster?ref=5.3"
  cluster_name           = var.cluster_name
  application            = var.application
  environment-name       = var.environment-name
  is-production          = var.is-production
  infrastructure-support = var.infrastructure-support
  team_name              = var.team_name
  number_cache_clusters  = var.number_cache_clusters
  node_type              = "cache.t2.small"
  engine_version         = "6.x"
  parameter_group_name   = "default.redis6.x"
  namespace              = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "hmpps_manage_adjudications" {
  metadata {
    name      = "elasticache-redis"
    namespace = var.namespace
  }

  data = {
    primary_endpoint_address = module.hmpps_manage_adjudications.primary_endpoint_address
    auth_token               = module.hmpps_manage_adjudications.auth_token
    member_clusters          = jsonencode(module.hmpps_manage_adjudications.member_clusters)
  }
}

