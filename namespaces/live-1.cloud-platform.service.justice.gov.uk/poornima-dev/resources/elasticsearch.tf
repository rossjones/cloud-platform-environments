
/*
 * Make sure that you use the latest version of the module by changing the
 * `ref=` value in the `source` attribute to the latest version listed on the
 * releases page of this repository.
 *
 */
module "example_team_es" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-elasticsearch?ref=es-eks-irsa"
  cluster_name           = var.cluster_name
  application            = "testApp"
  business-unit          = "HQ"
  environment-name       = "dev"
  infrastructure-support = "cloud-platform@digital.justice.gov.uk"
  is-production          = "false"
  team_name              = "webops"
  elasticsearch-domain   = "vj-test"
  namespace              = "poornima-dev"

  # change the elasticsearch version as you see fit.
  elasticsearch_version = "7.1"
}


module "ns_annotation" {
  source              = "github.com/ministryofjustice/cloud-platform-terraform-ns-annotation?ref=0.0.3"
  ns_annotation_roles = [module.example_team_es.aws_iam_role_name]
  namespace           = "poornima-dev"
}