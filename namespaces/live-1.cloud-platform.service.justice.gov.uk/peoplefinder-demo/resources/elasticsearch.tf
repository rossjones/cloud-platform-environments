################################################################################
# Peoplefinder
# Application Elasticsearch cluster
#################################################################################

module "peoplefinder_es" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-elasticsearch?ref=3.9.1"
  cluster_name           = var.cluster_name
  application            = "peoplefinder"
  business-unit          = "Central Digital"
  environment-name       = "demo"
  infrastructure-support = "people-finder-support@digital.justice.gov.uk"
  is-production          = "false"
  team_name              = "peoplefinder"
  elasticsearch-domain   = "es"
  namespace              = "peoplefinder-demo"
  elasticsearch_version  = "6.8"
  instance_type          = "t2.small.elasticsearch"
}

module "ns_annotation" {
  source              = "github.com/ministryofjustice/cloud-platform-terraform-ns-annotation?ref=0.0.3"
  ns_annotation_roles = [module.peoplefinder_es.aws_iam_role_name]
  namespace           = var.namespace
}
