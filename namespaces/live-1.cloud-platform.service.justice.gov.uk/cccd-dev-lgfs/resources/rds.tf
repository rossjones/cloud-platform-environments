/*
 * Make sure that you use the latest version of the module by changing the
 * `ref=` value in the `source` attribute to the latest version listed on the
 * releases page of this repository.
 *
 */

module "cccd_rds" {
  source                      = "github.com/ministryofjustice/cloud-platform-terraform-rds-instance?ref=5.15"
  cluster_name                = var.cluster_name
  team_name                   = var.team_name
  business-unit               = var.business-unit
  application                 = var.application
  is-production               = var.is-production
  namespace                   = var.namespace
  environment-name            = var.environment-name
  infrastructure-support      = var.infrastructure-support
  db_allocated_storage        = "50"
  db_instance_class           = "db.t3.small"
  db_engine_version           = "13"
  rds_family                  = "postgres13"
  allow_major_version_upgrade = "true"
  db_parameter                = [{ name = "rds.force_ssl", value = "0", apply_method = "immediate" }]

  providers = {
    # Can be either "aws.london" or "aws.ireland"
    aws = aws.london
  }
}

module "cccd_rds_restored" {
  source                      = "github.com/ministryofjustice/cloud-platform-terraform-rds-instance?ref=5.15"
  cluster_name                = var.cluster_name
  team_name                   = var.team_name
  business-unit               = var.business-unit
  application                 = var.application
  is-production               = var.is-production
  namespace                   = var.namespace
  environment-name            = var.environment-name
  infrastructure-support      = var.infrastructure-support
  db_allocated_storage        = "50"
  db_instance_class           = "db.t3.small"
  db_engine_version           = "9.6"
  rds_family                  = "postgres9.6"
  allow_major_version_upgrade = "true"
  db_parameter                = [{ name = "rds.force_ssl", value = "0", apply_method = "immediate" }]

  snapshot_identifier = "rds:preupgrade-cloud-platform-a149a0c2b2575f5f-9-6-20-to-13-1-1619451553557"

  providers = {
    # Can be either "aws.london" or "aws.ireland"
    aws = aws.london
  }
}

resource "kubernetes_secret" "cccd_rds" {
  metadata {
    name      = "cccd-rds"
    namespace = var.namespace
  }

  data = {
    access_key_id         = module.cccd_rds_restored.access_key_id
    secret_access_key     = module.cccd_rds_restored.secret_access_key
    rds_instance_endpoint = module.cccd_rds_restored.rds_instance_endpoint
    database_name         = module.cccd_rds_restored.database_name
    database_username     = module.cccd_rds_restored.database_username
    database_password     = module.cccd_rds_restored.database_password
    rds_instance_address  = module.cccd_rds_restored.rds_instance_address
    url                   = "postgres://${module.cccd_rds_restored.database_username}:${module.cccd_rds_restored.database_password}@${module.cccd_rds_restored.rds_instance_endpoint}/${module.cccd_rds_restored.database_name}"
  }
}
