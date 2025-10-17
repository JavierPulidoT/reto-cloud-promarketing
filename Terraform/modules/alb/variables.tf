# ---------------------------------------------------------------------------------------------------------------------
# PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "region" {
  description = "Sets the region"
  type        = string
}

variable "name" {
  type        = string
  description = "The name of the resources"
}

variable "tags" {
  #type        = map(string)
  default     = {}
  description = "tags, which could be used for additional tags"
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

