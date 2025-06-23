resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = "${var.s3_bucket_name}-${random_pet.this.id}"

  versioning {
    enabled = true
  }
}

resource "random_pet" "this" {
  length = 2
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AWSCloudTrailWrite",
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action = "s3:PutObject",
        Resource = "${aws_s3_bucket.cloudtrail_logs.arn}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}



output "depends_on_s3_bucket_object" {
  value = aws_s3_bucket_policy.cloudtrail_bucket_policy
}