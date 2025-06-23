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
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "s3:PutObject"
        Resource  = "${aws_s3_bucket.cloudtrail_logs.arn}/*"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      },
      {
        Effect    = "Allow"
        Action    = "s3:GetBucketAcl"
        Resource  = "${aws_s3_bucket.cloudtrail_logs.arn}"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      }
    ]
  })
}


output "depends_on_s3_bucket_object" {
  value = aws_s3_bucket_policy.cloudtrail_bucket_policy
}