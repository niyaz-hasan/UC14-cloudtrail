resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = "${var.s3_bucket_name}-${random_pet.this.id}"

  versioning {
    enabled = true
  }
  # Attach the S3 bucket policy allowing CloudTrail to write logs
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.cloudtrail_logs.arn}/*"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      }
    ]
  })
}


resource "random_pet" "this" {
  length = 2
}