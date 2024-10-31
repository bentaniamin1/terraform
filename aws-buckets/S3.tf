resource "aws_s3_bucket" "bucket_tf_file_amin" {
  bucket = "my-buckets-test-amin"

  tags = {
    Name        = "My bucket test"
    Environment = lookup(var.buckets_workspace, terraform.workspace, "dev")
  }
}