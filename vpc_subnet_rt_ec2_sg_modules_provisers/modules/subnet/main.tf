resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id_value
  cidr_block = var.cidr_block_value
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
  }
}