
variable "cluster_name" {
}

variable "kubernetes_cluster" {
}

variable "application" {
  description = "Name of Application you are deploying"
  default     = "MoJ Maintenance Pages"
}

variable "namespace" {
  default = "maintenance-pages"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "Platforms"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "operations-engineering"
}

variable "environment" {
  description = "The type of environment you're deploying to."
  default     = "production"
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "operations-engineering@digital.justice.gov.uk"
}

variable "is_production" {
  default = "true"
}

variable "slack_channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "operations-engineering-team"
}

# DEPRECATED: snake-case variables are the default. The definitions below
# have been left in place until all code has been updated to use snake-case
# variable names.

variable "business-unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "Platforms"
}

variable "team-name" {
  description = "The name of your development team"
  default     = "operations-engineering"
}

variable "infrastructure-support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "operations-engineering@digital.justice.gov.uk"
}

variable "is-production" {
  default = "true"
}

variable "slack-channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "operations-engineering-team"
}


variable "domains" {
  description = "List of domains to be put in maintenance"
  type        = any
  default     = ["nomisqc.justice.gov.uk"]
}

variable "github_owner" {
  description = "The GitHub organization or individual user account containing the app's code repo."
  default     = "ministryofjustice"
}

variable "github_token" {
  description = "Required by the Github Terraform provider"
  default     = ""
}