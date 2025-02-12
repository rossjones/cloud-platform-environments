
variable "cluster_name" {
}


variable "application" {
  description = "Name of Application you are deploying"
  default     = "Providing rehabilitation services to service users"
}

variable "namespace" {
  default = "hmpps-interventions-research"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "HMPPS"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "hmpps-interventions"
}

variable "environment" {
  description = "The type of environment you're deploying to."
  default     = "research"
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "interventions-devs@digital.justice.gov.uk"
}

variable "is_production" {
  default = "false"
}

variable "slack_channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "interventions"
}

variable "number_cache_clusters" {
  default = "2"
}

variable "rds_family" {
  default = "postgres10"
}
