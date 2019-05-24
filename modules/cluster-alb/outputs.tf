output "target_group_arns" {
  value = "${module.cluster_alb.target_group_arns}"
}

output "dns_name" {
  value = "${module.cluster_alb.dns_name}"
}

output "load_balancer_zone_id" {
  value = "${module.cluster_alb.load_balancer_zone_id}"
}

output "security_group_id" {
  value = "${module.cluster_alb_sg.this_security_group_id}"
}

output "http_tcp_listener_arns" {
  value = "${module.cluster_alb.http_tcp_listener_arns}"
}

output "http_tcp_listener_ids" {
  value = "${module.cluster_alb.http_tcp_listener_ids}"
}

output "https_listener_arns" {
  value = "${module.cluster_alb.https_listener_arns}"
}

output "https_listener_ids" {
  value = "${module.cluster_alb.https_listener_ids}"
}

output "load_balancer_arn_suffix" {
  value = "${module.cluster_alb.load_balancer_arn_suffix}"
}

output "load_balancer_id" {
  value = "${module.cluster_alb.load_balancer_id}"
}

output "target_group_arn_suffixes" {
  value = "${module.cluster_alb.target_group_arn_suffixes}"
}

output "target_group_names" {
  value = "${module.cluster_alb.target_group_names}"
}
