module "s3" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.6"

  team_name                     = var.team_name
  business-unit                 = "LAA"
  application                   = var.application
  is-production                 = var.is-production
  environment-name              = var.environment-name
  infrastructure-support        = var.infrastructure_support
  namespace                     = var.namespace
  acl                           = "public-read"
  enable_allow_block_pub_access = false

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "s3" {
  metadata {
    name      = "s3"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.s3.access_key_id
    secret_access_key = module.s3.secret_access_key
    bucket_arn        = module.s3.bucket_arn
    bucket_name       = module.s3.bucket_name
    region            = "eu-west-2"
  }
}
