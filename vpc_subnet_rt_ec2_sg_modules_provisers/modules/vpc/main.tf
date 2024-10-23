resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block_value
  instance_tenancy = "default"

  tags = {
    Name = var.tags_value
  }
}