###########
# Defaults
##########
terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.68"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "~> 0.13.0"
    }
  }
}
provider "aws" {
  region = var.region
}
################
## Security Group
################
resource "aws_security_group" "back" {
  description = "db-security-group-${var.name}"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  name = "db-security-group-${var.name}"
  vpc_id = var.vpc_id
}
################
## Subnet Group 
################

resource "aws_db_subnet_group" "rds-postgres" {
  name = "rds-subnet-group-${var.name}"
  subnet_ids = var.private_subnets
}
################
## SECRET MANAGER
################

resource "random_password" "master_password"{
  length           = 25
  special          = false
}

resource "aws_secretsmanager_secret" "password" {
  name = "secret-manager-promarketing-canada-v1"
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.password.id
  secret_string = random_password.master_password.result
}

################
## RDS
################

resource "aws_db_instance" "back-ms" {
  allocated_storage             = 10
  db_subnet_group_name          = aws_db_subnet_group.rds-postgres.name
  identifier                    = "rds-${var.name}"
  db_name                       = var.db_name
  engine                        = var.engine
  engine_version                = var.engine_version
  instance_class                = var.instance_class
  username                      = var.username
  password                      = random_password.master_password.result
  vpc_security_group_ids        = [aws_security_group.back.id]
  backup_retention_period       = 7
  backup_window                 = "07:00-08:00"
  maintenance_window            = "Sun:10:00-Sun:12:00"
  auto_minor_version_upgrade    = true
  allow_major_version_upgrade   = false
  multi_az                      = false
  skip_final_snapshot           = true
  publicly_accessible           = true
}
