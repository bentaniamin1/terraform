terraform {
  backend "s3" {
    encrypt = true   
    bucket = "my-buckets-test-amin"
    dynamodb_table = "aws_dynamodb_table"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}