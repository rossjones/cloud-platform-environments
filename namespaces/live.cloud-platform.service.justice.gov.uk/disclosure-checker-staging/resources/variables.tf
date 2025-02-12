variable "cluster_name" {
}

variable "cluster_state_bucket" {
}

variable "kubernetes_cluster" {
}

variable "team_name" {
  default = "family-justice"
}

variable "business_unit" {
  default = "HQ"
}

variable "environment_name" {
  default = "staging"
}

variable "is_production" {
  default = "false"
}

variable "infrastructure_support" {
  default = "crossjusticedelivery@digital.justice.gov.uk"
}

variable "application" {
  default = "Check when to disclose cautions or convictions"
}

variable "namespace" {
  default = "disclosure-checker-staging"
}

variable "repo_name" {
  default = "disclosure-checker"
}

variable "github_owner" {
  description = "The GitHub organization or individual user account containing the app's code repo. Used by the Github Terraform provider. See: https://user-guide.cloud-platform.service.justice.gov.uk/documentation/getting-started/ecr-setup.html#accessing-the-credentials"
  default     = "ministryofjustice"
}

variable "github_token" {
  description = "Required by the Github Terraform provider"
  default     = ""
}
