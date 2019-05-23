output "target_group_arns" {
  value = "${module.cluster_nlb.target_group_arns}"
}

output "dns_name" {
  value = "${module.cluster_nlb.dns_name}"
}
