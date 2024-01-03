terraform {
  cloud {
    organization = "madinaterraformcloud"

    workspaces {
      name = "billing-alert"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "billing_alert" {
  source = "binbashar/cost-billing-alarm/aws"

  aws_env = "AWS-CHARGING-YOU"
  monthly_billing_threshold = 4214.62
  currency = "USD"
}
resource "aws_cloudwatch_metric_alarm" "ec2_billing_alarm_1" {
  alarm_name          = "EC2BillingAlarmfor-apptier"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "60.00"  # Replace with your desired billing threshold amount for Alarm 1
  alarm_description   = "Alarm when EC2 estimated charges exceed threshold for Alarm 1"
}
resource "aws_cloudwatch_metric_alarm" "ec2_billing_alarm_2" {
  alarm_name          = "EC2BillingAlarmfor-webtier"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "0.00"  # Replace with your desired billing threshold amount for Alarm 2
  alarm_description   = "Alarm when EC2 estimated charges exceed threshold for Alarm 2"
}
resource "aws_db_instance" "example_rds_mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
}

resource "aws_cloudwatch_metric_alarm" "rds_mysql_billing_alarm" {
  alarm_name          = "RDSMySQLBillingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "3745.94"  # Replace with your desired billing threshold amount
  alarm_description   = "Alarm when RDS MySQL estimated charges exceed threshold"
}
resource "aws_cloudwatch_metric_alarm" "s3_billing_alarm" {
  alarm_name          = "S3BillingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "131.35"  # Replace with your desired billing threshold amount
  alarm_description   = "Alarm when S3 estimated charges exceed threshold"
}
# Create a CloudWatch Alarm for AWS WAF estimated charges
resource "aws_cloudwatch_metric_alarm" "waf_billing_alarm" {
  alarm_name          = "WAFBillingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "25.00"  # Replace with your desired billing threshold amount
  alarm_description   = "Alarm when AWS WAF estimated charges exceed threshold"
}
# Create an SNS topic for billing alerts related to SNS
resource "aws_sns_topic" "sns_billing_alert_topic" {
  name = "sns-billing-alert-topic"
}

# Create a CloudWatch Alarm for monitoring estimated charges related to SNS
resource "aws_cloudwatch_metric_alarm" "sns_billing_alarm" {
  alarm_name          = "SNSBillingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"  # This is a placeholder; AWS does not have a specific metric for SNS charges
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "204.48"  # Replace with your desired billing threshold amount
  alarm_description   = "Alarm when estimated charges for SNS exceed threshold"
  
  alarm_actions = [aws_sns_topic.sns_billing_alert_topic.arn]
}

# Output the ARN of the created SNS topic
output "sns_topic_arn" {
  value = aws_sns_topic.sns_billing_alert_topic.arn
}

# Output the ARN of the created CloudWatch Alarm
output "billing_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.sns_billing_alarm.alarm_name
}

# Create a CloudWatch Alarm for monitoring estimated charges related to Secrets Manager
resource "aws_cloudwatch_metric_alarm" "secrets_manager_billing_alarm" {
  alarm_name          = "SecretsManagerBillingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "11.00"  # Replace with your desired billing threshold amount
  alarm_description   = "Alarm when estimated charges for Secrets Manager exceed threshold"
}
# Create a CloudWatch Alarm for monitoring estimated charges
resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "BillingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "3.00"  # Replace with your desired billing threshold amount
  alarm_description   = "Alarm when estimated charges exceed threshold"
}
# Create an SNS topic for Route 53 billing alerts
resource "aws_sns_topic" "route53_billing_alert_topic" {
  name = "route53-billing-alert-topic"
}

# Create a CloudWatch Alarm for monitoring estimated charges related to Route 53
resource "aws_cloudwatch_metric_alarm" "route53_billing_alarm" {
  alarm_name          = "Route53BillingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"  # This is a placeholder; AWS does not have a specific metric for Route 53 charges
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "1.00"  # Replace with your desired billing threshold amount
  alarm_description   = "Alarm when estimated charges for Route 53 exceed threshold"
  
  alarm_actions = [aws_sns_topic.route53_billing_alert_topic.arn]
}
# Create an SNS topic for ELB billing alerts
resource "aws_sns_topic" "elb_billing_alert_topic" {
  name = "elb-billing-alert-topic"
}

# Create a CloudWatch Alarm for monitoring estimated charges related to ELB
resource "aws_cloudwatch_metric_alarm" "elb_billing_alarm" {
  alarm_name          = "ELBBillingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"  # This is a placeholder; AWS does not have a specific metric for ELB charges
  namespace           = "AWS/Billing"
  period              = "86400"  # 24 hours
  statistic           = "Maximum"
  threshold           = "32.85"  # Replace with your desired billing threshold amount
  alarm_description   = "Alarm when estimated charges for ELB exceed threshold"
  
  alarm_actions = [aws_sns_topic.elb_billing_alert_topic.arn]
}
resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = module.billing_alert.sns_topic_arns[0]
  protocol  = "email"
  endpoint  = "madinahakimova1999@gmail.com"
}
#fooreach-and-module