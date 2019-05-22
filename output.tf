output "blue_external_alb_security_group_id" {
  value = "${module.blue_cluster_external_alb.security_group_id}"
}

output "green_external_alb_security_group_id" {
  value = "${module.blue_cluster_external_alb.security_group_id}"
}

output "blue_internal_alb_security_group_id" {
  value = "${module.blue_cluster_internal_alb.security_group_id}"
}

output "green_internal_alb_security_group_id" {
  value = "${module.blue_cluster_internal_alb.security_group_id}"
}