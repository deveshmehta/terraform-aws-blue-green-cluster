output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = "${module.cluster_asg.this_autoscaling_group_id}"
}
output "this_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = "${module.cluster_asg.this_autoscaling_group_name}"
}

output "this_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = "${module.cluster_asg.this_autoscaling_group_arn}"
}
