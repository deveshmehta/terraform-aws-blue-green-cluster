# locals {
#   this_autoscaling_group_id = ["${element(concat(coalescelist(module.cluster_asg.this_autoscaling_group_id), list("")), 0)}"]
# #   this_autoscaling_group_name = "${element(concat(coalescelist(aws_autoscaling_group.this.*.name, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.name), list("")), 0)}"
# #   this_autoscaling_group_arn = "${element(concat(coalescelist(aws_autoscaling_group.this.*.arn, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.arn), list("")), 0)}"
# }

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
