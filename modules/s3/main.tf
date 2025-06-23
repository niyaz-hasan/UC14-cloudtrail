resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = var.s3_bucket_name

  versioning {
    enabled = true
  }
  
}