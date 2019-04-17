module "ecr-repo-support-labelling" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=3.1"

  team_name = "webops"
  repo_name = "support-labelling-webhooks"
}

resource "kubernetes_secret" "ecr-repo-api" {
  metadata {
    name      = "ecr-support-labelling-webhook"
    namespace = "support-labelling-webhook"
  }

  data {
    repo_url          = "${module.ecr-repo-api.repo_url}"
    access_key_id     = "${module.ecr-repo-api.access_key_id}"
    secret_access_key = "${module.ecr-repo-api.secret_access_key}"
  }
}
