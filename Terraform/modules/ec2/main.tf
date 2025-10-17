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

##########################
# IAM AND POLICY
##########################


data "aws_iam_policy_document" "admin" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}
resource "aws_iam_role" "admin" {
  assume_role_policy = data.aws_iam_policy_document.admin.json
  name               = var.iam_name
}
resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
resource "aws_iam_instance_profile" "admin" {
  name = var.iam_name
  role = aws_iam_role.admin.name
}


######################################
# Key pair
######################################

resource "tls_private_key" "llave" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.llave.public_key_openssh
}


################
## Security Groups
################
resource "aws_security_group" "allresource" {
  description = "security-group"

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



  name = "security-group-all"

  tags = {
    Env  = "Dev"
    Name = "security-group-all"
  }

  vpc_id = var.vpc_id

}

################
## EC2
################

resource "aws_instance" "frontsite" {
  ami                         = var.instance_ami
  associate_public_ip_address = false
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.admin.name
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.allresource.id]
  subnet_id                   =  element(var.private_subnets, 0)
  user_data = "${file("user-data.sh")}"
  root_block_device {
    volume_size                 = var.ebs_size
    volume_type                 = var.ebs_type
  }

  tags = {
    Name = var.instance_frontsite
  }
}

resource "aws_instance" "backoffice" {
  ami                         = var.instance_ami
  associate_public_ip_address = false
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.admin.name
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.allresource.id]
  subnet_id                   =  element(var.private_subnets, 0)
  user_data = "${file("user-data.sh")}"
  root_block_device {
    volume_size                 = var.ebs_size
    volume_type                 = var.ebs_type
  }

  tags = {
    Name = var.instance_backoffice
  }
}

resource "aws_instance" "webapi" {
  ami                         = var.instance_ami
  associate_public_ip_address = false
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.admin.name
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.allresource.id]
  subnet_id                   =  element(var.private_subnets, 0)
  user_data = "${file("user-data.sh")}"
  root_block_device {
    volume_size                 = var.ebs_size
    volume_type                 = var.ebs_type
  }

  tags = {
    Name = var.instance_webapi
  }
}

resource "aws_instance" "gameapi" {
  ami                         = var.instance_ami
  associate_public_ip_address = false
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.admin.name
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.allresource.id]
  subnet_id                   =  element(var.private_subnets, 0)
  user_data = "${file("user-data.sh")}"
  root_block_device {
    volume_size                 = var.ebs_size
    volume_type                 = var.ebs_type
  }

  tags = {
    Name = var.instance_gameapi
  }
}

