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
## Load Balancer 
################
resource "aws_alb" "public" {
  name            = "alb-promarketing-canada"
  security_groups = [aws_security_group.alb-public.id]

  subnets = var.public_subnets
  
}

################
## Security Group
################

resource "aws_security_group" "alb-public" {
  description = "security-group-alb-${var.name}"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }


  name = "security-group-alb-${var.name}"

  vpc_id = var.vpc_id
}


