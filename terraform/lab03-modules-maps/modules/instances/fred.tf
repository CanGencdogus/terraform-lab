variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = list(string)
}

variable "customer_name" {}
variable "environment" {}

resource "aws_instance" "web" {
  ami                         = "ami-0604c5d98f1afc4f9"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id         #aws_subnet.subnet_public.id
  vpc_security_group_ids      = var.security_group_id #[aws_security_group.sg_22_80.id]
  associate_public_ip_address = true

  tags = {
    Customer_Name                 = var.customer_name,
    Environment                   = var.environment,
    Customer_Name_and_Environment = join("", [var.customer_name, var.environment])
  }
}
