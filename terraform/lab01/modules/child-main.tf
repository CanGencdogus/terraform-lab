variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "helloworld"
  }
}
