output "dns_name" {
  value = "${module.cluster_clb.clb_dns_name}"
}

output "load_balancer_zone_id" {
  value = "${module.cluster_clb.clb_load_balancer_zone_id}"
}

output "load_balancer_arn_suffix" {
  value = "${module.cluster_clb.clb_load_balancer_arn_suffix}"
}

output "load_balancer_arns" {
  value = "${module.cluster_clb.clb_load_balancer_arns}"
}

output "load_balancer_id" {
  value = "${module.cluster_clb.clb_load_balancer_id}"
}
