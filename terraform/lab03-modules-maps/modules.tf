terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.42.0"
    }
  }
  required_version = ">= 0.14.5"
}

provider "aws" {
  region = var.region
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "myvar" {
  type    = string
  default = "production"
}

variable "fred_ingress" {
  default = {
    description = "my first test"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "vpc" {
  source      = "./modules/networking"
  cidr_vpc    = "10.1.0.0/16"
  cidr_subnet = "10.1.0.0/24"
}

module "security-groups" {
  source       = "./modules/security-groups"
  vpc_id       = module.vpc.vpc_id
  fred_ingress = var.fred_ingress
}

# variable "customer_name" {
#   type = list(string)
#   default = [
#    "barney",
#    "fred",
#    "bambam"
#   ]
# }

variable "customer_name" {
  type = map(string)
  default = {
    "barney" = "dev",
    "fred"   = "prod",
    "bambam" = "test"
  }
}

module "instance" {
  for_each          = tomap(var.customer_name)
  customer_name     = each.key
  environment       = each.value
  source            = "./modules/instances"
  subnet_id         = module.vpc.subnet_id
  security_group_id = [module.security-groups.security_group_id]
}

