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
variable "s3_name" {
  type        = string
  default     = "s3-promarketing-canada"
}
variable "tags" {
  #type        = map(string)
  default     = {}
  description = "tags, which could be used for additional tags"
}

variable "bucket_name" {
  type        = string
}

variable "bucket_id" {
  type        = string
}
