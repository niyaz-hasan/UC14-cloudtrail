module "S3" {
  source           = "./modules/s3"
  s3_bucket_name   = var.cloudtrail_s3_bucket_name
  
}

module "sns" {
  source           = "./modules/sns"
  email_recipient  = var.email_recipient
  sns_topic_name   = var.sns_topic_name
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  sns_topic_arn = module.sns.sns_topic_arn
  log_group_name = var.cloudwatch_log_group
}


module "cloudtrail" {
  source                = "./modules/cloudtrail"
  s3_bucket_name        = module.S3.cloudtrail_s3_bucket
  cloudwatch_log_group_arn  = module.cloudwatch.cloudwatch_log_group_arn
  depends_on_cloudwatch_log_group = module.cloudwatch.depends_on_cloudwatch_log_group
  depends_on_s3_bucket_object     = module.S3.depends_on_s3_bucket_object
}


