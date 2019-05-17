output "target_group_arns" {
  value = "${module.cluster_alb.target_group_arns}"
}

output "dns_name" {
  value = "${module.cluster_alb.dns_name}"
}

output "security_group_id" {
  value = "${module.cluster_alb_sg.this_security_group_id}"
}