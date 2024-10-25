provider "aws" {
  region = "us-east-1"
}

variable "type_ec2" {
  type = string
  default = "t2.micro"
  
}

variable "ami" {
  type = string
}

variable "instance_type_value" {
    type        = map(string)
    description = "value for instance_type"
    default = {
      "dev" = "t2.micro",
      "preprod" = "t2.medium",
      "prod" = "t2.large",

    }
}

variable "cidr_block_vpc" {
  type = string
  default = "10.0.0.0/16"
}
variable "cidr_block_subnet" {
  type = string
  default = "10.0.0.0/24"
}

resource "aws_key_pair" "amin" {
  key_name   = "amin_test"
  public_key = file("~/.ssh/id_rsa_tf.pub")
  }

module "vpc_m" {
  source = "./modules/vpc"
  cidr_block_value = var.cidr_block_vpc
  tags_value = "main"
}

module "subnet_m" {
  source = "./modules/subnet"
  cidr_block_value = var.cidr_block_subnet
  vpc_id_value = module.vpc_m.vpc_id
  
}
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc_m.vpc_id
}

resource "aws_route_table" "RT" {
  vpc_id = module.vpc_m.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rtaMain" {
  subnet_id      = module.subnet_m.subnet_id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = module.vpc_m.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

module "ec2_m" {
  source = "./modules/instances_ec2"
  ami_value = var.ami
  region_value = "us-east-1"
  value_instance = terraform.workspace
  key_name = aws_key_pair.amin.key_name
  security_group_id = aws_security_group.webSg.id
  subnet_id_value = module.subnet_m.subnet_id
}



