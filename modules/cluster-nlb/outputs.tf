output "target_group_arns" {
  value = "${module.cluster_nlb.target_group_arns}"
}

output "dns_name" {
  value = "${module.cluster_nlb.dns_name}"
}

output "load_balancer_zone_id" {
  value = "${module.cluster_nlb.load_balancer_zone_id}"
}

output "http_tcp_listener_arns" {
  value = "${module.cluster_nlb.http_tcp_listener_arns}"
}

output "http_tcp_listener_ids" {
  value = "${module.cluster_nlb.http_tcp_listener_ids}"
}

output "https_listener_arns" {
  value = "${module.cluster_nlb.https_listener_arns}"
}

output "https_listener_ids" {
  value = "${module.cluster_nlb.https_listener_ids}"
}

output "load_balancer_arn_suffix" {
  value = "${module.cluster_nlb.load_balancer_arn_suffix}"
}

output "load_balancer_id" {
  value = "${module.cluster_nlb.load_balancer_id}"
}

output "target_group_arn_suffixes" {
  value = "${module.cluster_nlb.target_group_arn_suffixes}"
}

output "target_group_names" {
  value = "${module.cluster_nlb.target_group_names}"
}
