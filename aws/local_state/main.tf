terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.2.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Look up the latest Debian 12 AMI
data "aws_ami" "debian12" {
  most_recent = true
  owners      = ["136693071363"] # Official Debian account on AWS Marketplace

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.debian12.id
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform_Demo"
  }
}
