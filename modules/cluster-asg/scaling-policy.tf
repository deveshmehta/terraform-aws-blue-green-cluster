##################################################################################
# Options App ASG Scaling Policy Primary
##################################################################################
# scale up alarm
resource "aws_autoscaling_policy" "cluster_asg_cpu_scaleup" {
  name                   = "${var.cluster_name}-${var.color}-scaleup-policy"
  autoscaling_group_name = "${module.cluster_asg.this_autoscaling_group_id}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "cluster_asg_cpu_scaleup" {
  alarm_name          = "${var.cluster_name}-${var.color}-scaleup-alarm"
  alarm_description   = "This metric monitors EC2 instance CPU utilization for scale up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions {
    AutoScalingGroupName = "${module.cluster_asg.this_autoscaling_group_id}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.cluster_asg_cpu_scaleup.arn}"]
}

# scale down alarm
resource "aws_autoscaling_policy" "cluster_asg_cpu_scaledown" {
  name                   = "${var.cluster_name}-${var.color}-scaledown-policy"
  autoscaling_group_name = "${module.cluster_asg.this_autoscaling_group_id}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
}

resource "aws_cloudwatch_metric_alarm" "cluster_asg_cpu_scaledown" {
  alarm_name          = "${var.cluster_name}-${var.color}-scaledown-policy"
  alarm_description   = "This metric monitors EC2 instance CPU utilization for scale down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    "AutoScalingGroupName" = "${module.cluster_asg.this_autoscaling_group_id}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.cluster_asg_cpu_scaledown.arn}"]
}
