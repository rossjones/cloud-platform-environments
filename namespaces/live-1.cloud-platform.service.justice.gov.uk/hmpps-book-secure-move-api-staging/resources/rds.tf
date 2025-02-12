module "rds-instance" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-rds-instance?ref=5.16.5"

  cluster_name = var.cluster_name

  application            = var.application
  environment-name       = var.environment-name
  is-production          = var.is-production
  namespace              = var.namespace
  infrastructure-support = var.infrastructure-support
  team_name              = var.team_name
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  # enable performance insights
  performance_insights_enabled = true

  providers = {
    aws = aws.london
  }

  db_parameter = [
    {
      name         = "rds.force_ssl"
      value        = "0"
      apply_method = "immediate"
    }
  ]
}

resource "kubernetes_secret" "rds-instance" {
  metadata {
    name      = "rds-instance-hmpps-book-secure-move-api-${var.environment-name}"
    namespace = var.namespace
  }

  data = {
    resource_id       = module.rds-instance.resource_id
    access_key_id     = module.rds-instance.access_key_id
    secret_access_key = module.rds-instance.secret_access_key
    url               = "postgres://${module.rds-instance.database_username}:${module.rds-instance.database_password}@${module.rds-instance.rds_instance_endpoint}/${module.rds-instance.database_name}"
  }
}

module "rds-read-replica" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-rds-instance?ref=5.16.5"

  cluster_name = var.cluster_name

  application            = var.application
  environment-name       = var.environment-name
  is-production          = var.is-production
  namespace              = var.namespace
  infrastructure-support = var.infrastructure-support
  team_name              = var.team_name

  # enable performance insights
  performance_insights_enabled = true

  db_name             = module.rds-instance.database_name
  replicate_source_db = module.rds-instance.db_identifier

  # Set to true for replica database. No backups or snapshots are created for read replica
  skip_final_snapshot        = "true"
  db_backup_retention_period = 0

  providers = {
    # Can be either "aws.london" or "aws.ireland"
    aws = aws.london
  }

  db_parameter = [
    {
      name         = "rds.force_ssl"
      value        = "0"
      apply_method = "immediate"
    }
  ]
}


resource "kubernetes_secret" "rds-read-replica" {
  metadata {
    name      = "read-rds-instance-hmpps-book-secure-move-api-${var.environment-name}"
    namespace = var.namespace
  }

  data = {
    resource_id       = module.rds-read-replica.resource_id
    access_key_id     = module.rds-instance.access_key_id
    secret_access_key = module.rds-instance.secret_access_key
    url               = "postgres://${module.rds-instance.database_username}:${module.rds-instance.database_password}@${module.rds-read-replica.rds_instance_endpoint}/${module.rds-read-replica.database_name}"
  }
}
