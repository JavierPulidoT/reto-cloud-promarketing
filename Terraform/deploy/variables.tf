variable "region" {
  description = "Sets the region"
  default     = "ca-central-1"
  type        = string
}
variable "namespace" {
  description = "Namespace, which could be your organiation name, e.g. amazon"
  default     = "promarketing"
}
variable "env" {
  description = "environment, e.g. 'sit', 'uat', 'prod' etc"
  default     = "canada"
}
#variable "name_pre_production" {
#  description = "vpc name"
#  default     = "vpc"
#}
variable "delimiter_pre_production" {
  description = "Delimiter, which could be used between name, namespace and env"
  default     = "-"
}
variable "tags_pre_production" {
  default     = {}
  description = "Tags, which could be used for additional tags"
}
variable "create_vpc_pre_production" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}
variable "enable_dns_hostnames_pre_production" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
variable "enable_dns_support_pre_production" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "instance_tenancy_pre_production" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}
variable "cidr_pre_production" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.100.0.0/16"
}
variable "public_pre_production" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.100.1.0/24","10.100.2.0/24"]
}
variable "private_pre_production" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.100.3.0/24","10.100.4.0/24"]
}
