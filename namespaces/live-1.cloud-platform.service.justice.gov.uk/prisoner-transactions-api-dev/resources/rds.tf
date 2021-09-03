module "prisoner_transactions_api_rds" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-rds-instance?ref=5.16.5"
  cluster_name           = var.cluster_name
  team_name              = var.team_name
  business-unit          = var.business_unit
  application            = var.application
  is-production          = var.is_production
  namespace              = var.namespace
  environment-name       = var.environment
  infrastructure-support = var.infrastructure_support


  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "prisoner_transactions_api_rds" {
  metadata {
    name      = "rds-instance-output"
    namespace = var.namespace
  }

  data = {
    rds_instance_endpoint = module.prisoner_transactions_api_rds.rds_instance_endpoint
    database_name         = module.prisoner_transactions_api_rds.database_name
    database_username     = module.prisoner_transactions_api_rds.database_username
    database_password     = module.prisoner_transactions_api_rds.database_password
    rds_instance_address  = module.prisoner_transactions_api_rds.rds_instance_address
    access_key_id         = module.prisoner_transactions_api_rds.access_key_id
    secret_access_key     = module.prisoner_transactions_api_rds.secret_access_key
  }
}
