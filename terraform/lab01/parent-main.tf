#### Resource # 2
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "instance" {
  source        = "./modules"
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}


# resource "aws_instance" "web" {
#   ami           = data.aws_ami.ubuntu.id #/ name / object_id / client_iud
#   instance_type = "t3.micro"

#   tags = {
#     Name = var.name
#   }
# }

# resource "aws_default_vpc" "default" {
#   tags = {
#     Name = var.name
#     Customer = "gokhan-${var.name}"
#     Location = "east-us-1" 
#   }
# }
