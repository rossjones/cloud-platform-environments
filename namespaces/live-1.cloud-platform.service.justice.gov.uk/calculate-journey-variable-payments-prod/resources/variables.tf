
variable "cluster_name" {
}


variable "application" {
  description = "Name of Application you are deploying"
  default     = "Calculate Journey Variable Payments"
}

variable "namespace" {
  default = "calculate-journey-variable-payments-prod"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "HMPPS"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "calculate-journey-variable-payments"
}

variable "environment" {
  description = "The type of environment you're deploying to."
  default     = "prod"
}

variable "environment-name" {
  description = "The environment name identifier."
  default     = "prod"
}


variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "calculatejourneypayments@digital.justice.gov.uk"
}

variable "is_production" {
  default = "true"
}

variable "slack_channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "calculate-journey-payments"
}

# DEPRECATED: snake-case variables are the default. The definitions below
# have been left in place until all code has been updated to use snake-case
# variable names.

variable "business-unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "HMPPS"
}

variable "team-name" {
  description = "The name of your development team"
  default     = "calculate-journey-variable-payments"
}

variable "infrastructure-support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "pecs-digital-tech@digital.justice.gov.uk"
}

variable "is-production" {
  default = "true"
}

variable "slack-channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "calculate-journey-payments"
}

