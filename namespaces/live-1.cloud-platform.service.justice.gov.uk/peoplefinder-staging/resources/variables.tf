/*
 * When using this module through the cloud-platform-environments, the following
 * two variables are automatically supplied by the pipeline.
 */

variable "cluster_name" {}

variable "namespace" {
  default = "peoplefinder-staging"
}

variable "domain" {
  default = "staging.peoplefinder.service.gov.uk"
}

variable "is-production" {
  default = "false"
}

variable "environment-name" {
  default = "staging"
}
