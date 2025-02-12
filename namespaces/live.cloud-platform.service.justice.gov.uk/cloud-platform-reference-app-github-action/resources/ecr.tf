module "ecr-repo" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=4.5"

  team_name    = var.team_name
  repo_name    = "${var.namespace}-ecr"
  scan_on_push = "false"

  # Uncomment and provide repository names to create github actions secrets
  # containing the ECR name, AWS access key, and AWS secret key, for use in
  # github actions CI/CD pipelines
  github_repositories = ["cloud-platform-reference-app-github-action"]
}

resource "kubernetes_secret" "ecr-repo" {
  metadata {
    name      = "ecr-repo-${var.namespace}"
    namespace = var.namespace
  }

  data = {
    repo_url          = module.ecr-repo.repo_url
    access_key_id     = module.ecr-repo.access_key_id
    secret_access_key = module.ecr-repo.secret_access_key
    repo_arn          = module.ecr-repo.repo_arn
  }
}
