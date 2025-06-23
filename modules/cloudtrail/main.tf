resource "aws_cloudtrail" "this" {
  name                          = "global-cloudtrail"
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  s3_bucket_name                = var.s3_bucket_name
  include_global_service_events = true
  cloud_watch_logs_group_arn    = var.cloudwatch_log_group_arn
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_log_role.arn
}



resource "aws_iam_role" "cloudtrail_log_role" {
  name = "cloudtrail_log_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}



output "cloudtrail_log_role_arn" {
  value = aws_iam_role.cloudtrail_log_role.arn
}
