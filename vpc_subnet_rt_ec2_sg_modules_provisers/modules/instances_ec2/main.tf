
resource "aws_instance" "example" {
  ami           = var.ami_value
  instance_type = var.instance_type_value
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id_value
}