variable "vpc_id" {
  type = string
}

variable "fred_ingress" {}

resource "aws_security_group" "sg_22_80" {
  name   = "sg_22_80"
  vpc_id = var.vpc_id

  # SSH access from the VPC
  ingress {
    description = var.fred_ingress.description
    from_port   = var.fred_ingress.from_port
    to_port     = var.fred_ingress.to_port
    protocol    = var.fred_ingress.protocol
    cidr_blocks = var.fred_ingress.cidr_blocks
  }

}

output "security_group_id" {
  value = aws_security_group.sg_22_80.id
}
