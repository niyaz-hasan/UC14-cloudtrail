variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "cloudtrail_s3_bucket_name" {
  description = "S3 bucket name to store CloudTrail logs"
  default     = "my-cloudtrail-logs-bucket"
}

variable "cloudwatch_log_group" {
  description = "CloudWatch log group name"
  default     = "/aws/cloudtrail/logs"
}

variable "email_recipient" {
  description = "The email address to send notifications to"
  default     = "niyaz.hasanmohamed@hcltech.com"
}

variable "sns_topic_name" {
  description = "SNS topic name for login event notifications"
  default     = "security-alerts"
}
