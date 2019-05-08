##################################################################################
# Options App ASG Scaling Policy Primary
##################################################################################
# scale up alarm
resource "aws_autoscaling_policy" "cluster_asg_1_cpu_scaleup" {
  name                   = "${var.cluster_asg_1_cpu_scaleup_policy}"
  autoscaling_group_name = "${module.cluster_asg_1.this_autoscaling_group_id}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "cluster_asg_1_cpu_scaleup" {
  alarm_name          = "${var.cluster_asg_1_cpu_scaleup_alarm}"
  alarm_description   = "This metric monitor Options ASG 1 instance cpu utilization scaleup"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions {
    AutoScalingGroupName = "${module.cluster_asg_1.this_autoscaling_group_id}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.cluster_asg_1_cpu_scaleup.arn}"]
}

# scale down alarm
resource "aws_autoscaling_policy" "cluster_asg_1_cpu_scaledown" {
  name                   = "${var.cluster_asg_1_cpu_scaledown_policy}"
  autoscaling_group_name = "${module.cluster_asg_1.this_autoscaling_group_id}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
}

resource "aws_cloudwatch_metric_alarm" "cluster_asg_1_cpu_scaledown" {
  alarm_name          = "${var.cluster_asg_1_cpu_scaledown_alarm}"
  alarm_description   = "This metric monitor EC2 instance cpu utilization scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    "AutoScalingGroupName" = "${module.cluster_asg_1.this_autoscaling_group_id}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.cluster_asg_1_cpu_scaledown.arn}"]
}

##################################################################################
# Options App ASG Scaling Policy Secondary
##################################################################################
# scale up alarm
resource "aws_autoscaling_policy" "cluster_asg_2_cpu_scaleup" {
  name                   = "${var.cluster_asg_2_cpu_scaleup_policy}"
  autoscaling_group_name = "${module.cluster_asg_2.this_autoscaling_group_id}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "cluster_asg_2_cpu_scaleup" {
  alarm_name          = "${var.cluster_asg_2_cpu_scaleup_alarm}"
  alarm_description   = "This metric monitor Options ASG 1 instance cpu utilization scaleup"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions {
    AutoScalingGroupName = "${module.cluster_asg_2.this_autoscaling_group_id}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.cluster_asg_2_cpu_scaleup.arn}"]
}

# scale down alarm
resource "aws_autoscaling_policy" "cluster_asg_2_cpu_scaledown" {
  name                   = "${var.cluster_asg_2_cpu_scaledown_policy}"
  autoscaling_group_name = "${module.cluster_asg_2.this_autoscaling_group_id}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
}

resource "aws_cloudwatch_metric_alarm" "cluster_asg_2_cpu_scaledown" {
  alarm_name          = "${var.cluster_asg_2_cpu_scaledown_alarm}"
  alarm_description   = "This metric monitor EC2 instance cpu utilization scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    "AutoScalingGroupName" = "${module.cluster_asg_2.this_autoscaling_group_id}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.cluster_asg_2_cpu_scaledown.arn}"]
}
