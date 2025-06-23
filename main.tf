provider "aws" {
  region = var.region
}

module "S3" {
  source           = "./module/s3"
  s3_bucket_name   = var.cloudtrail_s3_bucket_name
  
}
module "cloudtrail" {
  source                = "./modules/cloudtrail"
  cloudwatch_log_group  = var.cloudwatch_log_group
  cloudtrail_log_role_arn = module.cloudwatch.log_role_arn
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  log_group_name = var.cloudwatch_log_group
}

module "sns" {
  source           = "./modules/sns"
  email_recipient  = var.email_recipient
  sns_topic_name   = var.sns_topic_name
}

output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}
