resource "aws_cloudwatch_log_group" "cloudtrail_logs" {
  name = var.log_group_name
}

resource "aws_cloudwatch_log_metric_filter" "console_login_filter" {
  log_group_name = var.log_group_name
  filter_pattern = "{ $.eventName = \"ConsoleLogin\" && $.responseElements.ConsoleLogin = \"Success\" }"
  metric_transformation {
    name      = "ConsoleLoginSuccess"
    namespace = "Security"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console_login_alarm" {
  alarm_name          = "ConsoleLoginSuccessAlarm"
  metric_name         = "ConsoleLoginSuccess"
  namespace           = "Security"
  statistic           = "Sum"
  period              = 300
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  alarm_actions       = var.sns_topic_arn
}
