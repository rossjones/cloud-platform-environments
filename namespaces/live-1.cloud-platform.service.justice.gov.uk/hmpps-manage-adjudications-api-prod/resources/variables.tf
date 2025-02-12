variable "domain" {
  default = "manage-adjudications-api.hmpps.service.justice.gov.uk"
}

variable "application" {
  default = "hmpps-manage-adjudications-api"
}

variable "namespace" {
  default = "hmpps-manage-adjudications-api-prod"
}

variable "business-unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "HMPPS"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "Digital Prison Services/New Nomis"
}

variable "environment-name" {
  description = "The type of environment you're deploying to."
  default     = "prod"
}

variable "infrastructure-support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "dps-hmpps@digital.justice.gov.uk"
}

variable "is-production" {
  default = "true"
}

