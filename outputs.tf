output "instance_security_group_id" {
  value = "${module.cluster_sg.this_security_group_id}"
}

output "cluster_security_group_id" {
  value = "${module.cluster_sg.this_security_group_id}"
}

output "instance_iam_role_arn" {
  value = "${aws_iam_role.instance.arn}"
}

output "instance_iam_role_name" {
  value = "${aws_iam_role.instance.name}"
}
