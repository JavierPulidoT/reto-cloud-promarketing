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

variable "db_name" {
  default     = "back"
}

variable "engine" {
  default     = "postgres"
}

variable "engine_version" {
  default     = "17.6"
}

variable "instance_class" {
  default     = "db.t3.micro"
}

variable "username" {
  default     = "javi_root"
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
 type = list(string)
}

variable "public_subnets" {
  type = list(string)
}


