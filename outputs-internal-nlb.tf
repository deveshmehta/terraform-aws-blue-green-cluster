#####
# DNS
#####

output "internal_nlb_weighted_fqdn" {
  value = "${element(coalescelist(aws_route53_record.blue_cluster_internal_nlb.*.fqdn, aws_route53_record.green_cluster_internal_nlb.*.fqdn, list("")), 0)}"
}

output "internal_nlb_weighted_dns_name" {
  value = "${element(coalescelist(aws_route53_record.blue_cluster_internal_nlb.*.name, aws_route53_record.green_cluster_internal_nlb.*.name, list("")), 0)}"
}

########
# BLUE
########

output "blue_internal_nlb_dns_name" {
  value = "${module.blue_cluster_internal_nlb.dns_name}"
}

output "blue_internal_nlb_http_tcp_listener_arns" {
  value = "${module.blue_cluster_internal_nlb.http_tcp_listener_arns}"
}

output "blue_internal_nlb_http_tcp_listener_ids" {
  value = "${module.blue_cluster_internal_nlb.http_tcp_listener_ids}"
}

output "blue_internal_nlb_https_listener_arns" {
  value = "${module.blue_cluster_internal_nlb.https_listener_arns}"
}

output "blue_internal_nlb_https_listener_ids" {
  value = "${module.blue_cluster_internal_nlb.https_listener_ids}"
}

output "blue_internal_nlb_load_balancer_arn_suffix" {
  value = "${module.blue_cluster_internal_nlb.load_balancer_arn_suffix}"
}

output "blue_internal_nlb_load_balancer_id" {
  value = "${module.blue_cluster_internal_nlb.load_balancer_id}"
}

output "blue_internal_nlb_load_balancer_zone_id" {
  value = "${module.blue_cluster_internal_nlb.load_balancer_zone_id}"
}

output "blue_internal_nlb_target_group_arn_suffixes" {
  value = "${module.blue_cluster_internal_nlb.target_group_arn_suffixes}"
}

output "blue_internal_nlb_target_group_arns" {
  value = "${module.blue_cluster_internal_nlb.target_group_arns}"
}

output "blue_internal_nlb_target_group_names" {
  value = "${module.blue_cluster_internal_nlb.target_group_names}"
}


########
# GREEN
########

output "green_internal_nlb_dns_name" {
  value = "${module.green_cluster_internal_nlb.dns_name}"
}

output "green_internal_nlb_http_tcp_listener_arns" {
  value = "${module.green_cluster_internal_nlb.http_tcp_listener_arns}"
}

output "green_internal_nlb_http_tcp_listener_ids" {
  value = "${module.green_cluster_internal_nlb.http_tcp_listener_ids}"
}

output "green_internal_nlb_https_listener_arns" {
  value = "${module.green_cluster_internal_nlb.https_listener_arns}"
}

output "green_internal_nlb_https_listener_ids" {
  value = "${module.green_cluster_internal_nlb.https_listener_ids}"
}

output "green_internal_nlb_load_balancer_arn_suffix" {
  value = "${module.green_cluster_internal_nlb.load_balancer_arn_suffix}"
}

output "green_internal_nlb_load_balancer_id" {
  value = "${module.green_cluster_internal_nlb.load_balancer_id}"
}

output "green_internal_nlb_load_balancer_zone_id" {
  value = "${module.green_cluster_internal_nlb.load_balancer_zone_id}"
}

output "green_internal_nlb_target_group_arn_suffixes" {
  value = "${module.green_cluster_internal_nlb.target_group_arn_suffixes}"
}

output "green_internal_nlb_target_group_arns" {
  value = "${module.green_cluster_internal_nlb.target_group_arns}"
}

output "green_internal_nlb_target_group_names" {
  value = "${module.green_cluster_internal_nlb.target_group_names}"
}
