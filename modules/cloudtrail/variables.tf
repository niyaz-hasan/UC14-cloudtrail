variable "s3_bucket_name" {
  description = "S3 bucket name to store CloudTrail logs"
}

variable "cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch Log Group"
}

variable "depends_on_cloudwatch_log_group" {
}

variable "depends_on_s3_bucket_object" {
}
#variable "cloudtrail_log_role_arn" {
#  description = "The ARN of the IAM role for CloudTrail logs"
#}
