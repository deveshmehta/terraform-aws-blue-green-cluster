#####
# DNS
#####

output "internal_alb_weighted_fqdn" {
  value = "${element(coalescelist(aws_route53_record.blue_cluster_internal_alb.*.fqdn, aws_route53_record.green_cluster_internal_alb.*.fqdn, list("")), 0)}"
}

output "internal_alb_weighted_dns_name" {
  value = "${element(coalescelist(aws_route53_record.blue_cluster_internal_alb.*.name, aws_route53_record.green_cluster_internal_alb.*.name, list("")), 0)}"
}

########
# BLUE
########

output "blue_internal_alb_dns_name" {
  value = "${module.blue_cluster_internal_alb.dns_name}"
}

output "blue_internal_alb_security_group_id" {
  value = "${module.blue_cluster_internal_alb.security_group_id}"
}

output "blue_internal_alb_http_tcp_listener_arns" {
  value = "${module.blue_cluster_internal_alb.http_tcp_listener_arns}"
}

output "blue_internal_alb_http_tcp_listener_ids" {
  value = "${module.blue_cluster_internal_alb.http_tcp_listener_ids}"
}

output "blue_internal_alb_https_listener_arns" {
  value = "${module.blue_cluster_internal_alb.https_listener_arns}"
}

output "blue_internal_alb_https_listener_ids" {
  value = "${module.blue_cluster_internal_alb.https_listener_ids}"
}

output "blue_internal_alb_load_balancer_arn_suffix" {
  value = "${module.blue_cluster_internal_alb.load_balancer_arn_suffix}"
}

output "blue_internal_alb_load_balancer_id" {
  value = "${module.blue_cluster_internal_alb.load_balancer_id}"
}

output "blue_internal_alb_load_balancer_zone_id" {
  value = "${module.blue_cluster_internal_alb.load_balancer_zone_id}"
}

output "blue_internal_alb_target_group_arn_suffixes" {
  value = "${module.blue_cluster_internal_alb.target_group_arn_suffixes}"
}

output "blue_internal_alb_target_group_arns" {
  value = "${module.blue_cluster_internal_alb.target_group_arns}"
}

output "blue_internal_alb_target_group_names" {
  value = "${module.blue_cluster_internal_alb.target_group_names}"
}

########
# GREEN
########

output "green_internal_alb_security_group_id" {
  value = "${module.green_cluster_internal_alb.security_group_id}"
}

output "green_internal_alb_dns_name" {
  value = "${module.green_cluster_internal_alb.dns_name}"
}

output "green_internal_alb_http_tcp_listener_arns" {
  value = "${module.green_cluster_internal_alb.http_tcp_listener_arns}"
}

output "green_internal_alb_http_tcp_listener_ids" {
  value = "${module.green_cluster_internal_alb.http_tcp_listener_ids}"
}

output "green_internal_alb_https_listener_arns" {
  value = "${module.green_cluster_internal_alb.https_listener_arns}"
}

output "green_internal_alb_https_listener_ids" {
  value = "${module.green_cluster_internal_alb.https_listener_ids}"
}

output "green_internal_alb_load_balancer_arn_suffix" {
  value = "${module.green_cluster_internal_alb.load_balancer_arn_suffix}"
}

output "green_internal_alb_load_balancer_id" {
  value = "${module.green_cluster_internal_alb.load_balancer_id}"
}

output "green_internal_alb_load_balancer_zone_id" {
  value = "${module.green_cluster_internal_alb.load_balancer_zone_id}"
}

output "green_internal_alb_target_group_arn_suffixes" {
  value = "${module.green_cluster_internal_alb.target_group_arn_suffixes}"
}

output "green_internal_alb_target_group_arns" {
  value = "${module.green_cluster_internal_alb.target_group_arns}"
}

output "green_internal_alb_target_group_names" {
  value = "${module.green_cluster_internal_alb.target_group_names}"
}
