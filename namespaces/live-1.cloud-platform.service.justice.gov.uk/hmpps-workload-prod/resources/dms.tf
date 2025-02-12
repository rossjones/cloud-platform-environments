module "hmpps-workload-dms" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-dms?ref=2.0"

  cluster_name           = var.cluster_name
  namespace              = var.namespace
  application            = var.application
  business-unit          = var.business_unit
  environment-name       = var.environment
  infrastructure-support = var.infrastructure_support
  is-production          = var.is_production
  team_name              = var.team_name
}

data "kubernetes_secret" "dms_secret" {
  metadata {
    name      = "dms-secret"
    namespace = var.namespace
  }
}

resource "random_id" "dms_rand" {
  byte_length = 8
}

resource "aws_dms_endpoint" "source-azure" {
  endpoint_id                 = "${var.team_name}-srcazure-${random_id.dms_rand.hex}"
  endpoint_type               = "source"
  engine_name                 = data.kubernetes_secret.dms_secret.data.src_engine
  extra_connection_attributes = ""
  server_name                 = data.kubernetes_secret.dms_secret.data.src_addr
  database_name               = data.kubernetes_secret.dms_secret.data.src_database
  username                    = data.kubernetes_secret.dms_secret.data.src_user
  password                    = data.kubernetes_secret.dms_secret.data.src_pass
  port                        = data.kubernetes_secret.dms_secret.data.src_port
  ssl_mode                    = data.kubernetes_secret.dms_secret.data.src_ssl

  tags = {
    Name        = "${var.team_name} Source Endpoint"
    Description = "Current WMT Live database"
    Application = var.application
    Owner       = var.team_name
    Env         = var.environment
  }
}

resource "aws_dms_endpoint" "target-postgres" {
  endpoint_id                 = "${var.team_name}-dstpostgres-${random_id.dms_rand.hex}"
  endpoint_type               = "target"
  engine_name                 = data.kubernetes_secret.dms_secret.data.dst_engine
  extra_connection_attributes = ""
  server_name                 = data.kubernetes_secret.dms_secret.data.dst_addr
  database_name               = data.kubernetes_secret.dms_secret.data.dst_database
  username                    = data.kubernetes_secret.dms_secret.data.dst_user
  password                    = data.kubernetes_secret.dms_secret.data.dst_pass
  port                        = data.kubernetes_secret.dms_secret.data.dst_port
  ssl_mode                    = data.kubernetes_secret.dms_secret.data.dst_ssl

  tags = {
    Name        = "${var.team_name} Destination Endpoint"
    Description = "New WMT Database"
    Application = var.application
    Owner       = var.team_name
    Env         = var.environment
  }
}

resource "aws_dms_replication_task" "replication_task" {
  migration_type           = "full-load"
  replication_instance_arn = module.hmpps-workload-dms.replication_instance_arn
  replication_task_id      = "${var.team_name}-repl-${random_id.dms_rand.hex}"

  source_endpoint_arn = aws_dms_endpoint.source-azure.endpoint_arn
  target_endpoint_arn = aws_dms_endpoint.target-postgres.endpoint_arn

  table_mappings            = trimspace(file("settings/dms_table_mappings.json"))
  replication_task_settings = trimspace(file("settings/dms-replication-task-settings.json"))

  tags = {
    Name        = "${var.team_name} Replication Task"
    Description = "Managed by Terraform"
    Application = var.application
    Owner       = var.team_name
    Env         = var.environment
  }
}

resource "kubernetes_secret" "dms_instance" {
  metadata {
    name      = "dms-instance"
    namespace = var.namespace
  }

  data = {
    replication_instance_arn = module.hmpps-workload-dms.replication_instance_arn
    access_key_id            = module.hmpps-workload-dms.access_key_id
    secret_access_key        = module.hmpps-workload-dms.secret_access_key
    source                   = aws_dms_endpoint.source-azure.endpoint_arn
    destination              = aws_dms_endpoint.target-postgres.endpoint_arn
    task                     = aws_dms_replication_task.replication_task.replication_task_arn
  }
}