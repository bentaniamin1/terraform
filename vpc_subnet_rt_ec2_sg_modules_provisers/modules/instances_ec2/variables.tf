variable "region_value" {
    type        = string
    description = "value region"
}
variable "ami_value" {
    type        = string
    description = "value for the ami"

  validation {
    condition     = length(var.ami_value) > 4 && substr(var.ami_value, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
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

variable "value_instance" {
    type        = string
    description = "value instance"
}
variable "subnet_id_value" {
    type        = string
    description = "value for the subnet_id"
}
variable "key_name" {
    type        = string
    description = "value for the key name"
}
variable "security_group_id" {
    type        = string
    description = "id group security"
}