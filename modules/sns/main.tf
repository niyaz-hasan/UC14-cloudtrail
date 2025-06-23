resource "aws_sns_topic" "security_alerts" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "security_email_subscription" {
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = var.email_recipient
}

output "sns_topic_arn" {
  value = aws_sns_topic.security_alerts.arn
}
