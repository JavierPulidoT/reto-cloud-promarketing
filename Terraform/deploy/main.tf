# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.15.1 syntax, which means it is no longer compatible with any versions below 0.15.1.
# ----------------------------------------------------------------------------------------------------------------------
######################################
# Defaults
######################################
terraform {
  required_version = ">= 0.15.0"
}

provider "aws" {
  region = var.region
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "random_string" "rand4" {
  length  = 4
  special = false
  upper   = false
}
######################################
# TAGS module
######################################

module "label_tags_pre_production" {
  source    = "aws-ia/label/aws"
  version   = "0.0.5"
  namespace = var.namespace
  env       = "${var.env}"
  #name      = "${var.name_pre_production}"
  delimiter = var.delimiter_pre_production
  tags      = tomap({ propogate_at_launch = "true", "terraform" = "true" })
}


######################################
# VPC module
######################################
module "quickstart_networking" {
  source            = "../modules/networking"
  create_vpc        = var.create_vpc_pre_production
  name              = module.label_tags_pre_production.id
  region            = var.region
  cidr              = var.cidr_pre_production
  public_subnets    = var.public_pre_production
  private_subnets   = var.private_pre_production
  tags              = module.label_tags_pre_production.tags
}

######################################
# EC2 module
######################################
module "quickstart_ec2" {
  source            = "../modules/ec2"
  name              = module.label_tags_pre_production.id
  region            = var.region
  tags              = module.label_tags_pre_production.tags
  vpc_id            = module.quickstart_networking.vpc_id
  private_subnets   = module.quickstart_networking.private_subnets
}

######################################
# RDS module
######################################
module "quickstart_rds" {
  source            = "../modules/rds"
  name              = module.label_tags_pre_production.id
  region            = var.region
  vpc_id            = module.quickstart_networking.vpc_id
  public_subnets    = module.quickstart_networking.public_subnets
  private_subnets   = module.quickstart_networking.private_subnets
  tags              = module.label_tags_pre_production.tags 
}

######################################
# ALB module
######################################
module "quickstart_alb_public" {
  source            = "../modules/alb"
  name              = module.label_tags_pre_production.id
  region            = var.region
  vpc_id            = module.quickstart_networking.vpc_id
  public_subnets    = module.quickstart_networking.public_subnets
  tags              = module.label_tags_pre_production.tags

}


######################################
# S3 module
######################################
module "quickstart_s3" {
  source            = "../modules/s3"
  name              = module.label_tags_pre_production.id
  region            = var.region
  tags              = module.label_tags_pre_production.tags 
}

######################################
# CLOUDFRONT module
######################################
module "quickstart_cloufront" {
  source            = "../modules/cloudfront"
  name              = module.label_tags_pre_production.id
  region            = var.region
  tags              = module.label_tags_pre_production.tags 
  bucket_name       = module.quickstart_s3.bucket_name
  bucket_id         = module.quickstart_s3.bucket_id
}