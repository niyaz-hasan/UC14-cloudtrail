module "S3" {
  source           = "./modules/s3"
  s3_bucket_name   = var.cloudtrail_s3_bucket_name
  
}

module "sns" {
  source           = "./modules/sns"
  email_recipient  = var.email_recipient
  sns_topic_name   = var.sns_topic_name
}

module "cloudtrail" {
  source                = "./modules/cloudtrail"
  s3_bucket_name        = module.S3.cloudtrail_s3_bucket_arn
  cloudwatch_log_group  = var.cloudwatch_log_group
  cloudtrail_log_role_arn = module.cloudwatch.log_role_arn
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  sns_topic_arn = module.sns.sns_topic_arn
  log_group_name = var.cloudwatch_log_group
}

output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}
