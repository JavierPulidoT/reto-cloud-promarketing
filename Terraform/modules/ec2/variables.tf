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

variable "private_subnets" {
 type = list(string)
}

variable "instance_ami" {
  description = "Select the ami for the aws instances"
  default     = "ami-03814457ed908d8f6"
}

variable "instance_type" {
  description = "Select the type for the aws instances"
  default     = "t2.micro"
}

variable "instance_frontsite" {
  description = "instance-tag-name"
  default     = "ec2-promarketing-canada-frontsite"
}

variable "instance_backoffice" {
  description = "instance-tag-name"
  default     = "ec2-promarketing-canada-backoffice"
}

variable "instance_webapi" {
  description = "instance-tag-name"
  default     = "ec2-promarketing-canada-webapi"
}

variable "instance_gameapi" {
  description = "instance-tag-name"
  default     = "ec2-promarketing-canada-gameapi"
}

variable "ebs_size" {
  description = "Size to ebs"
  default     = "15"
}

variable "ebs_type" {
  description = "Size to ebs"
  default     = "gp2"
}

variable "iam_name" {
  description = "The name of the policy "   
  default     = "AdminPolicy"  
}

variable "key_name" {
  description = "The name of the key_pair "   
  default     = "keypair-promarketing-canada-all"  
  }





