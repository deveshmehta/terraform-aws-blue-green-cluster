#####
# DNS
#####

output "internal_clb_weighted_fqdn" {
  value = "${element(coalescelist(aws_route53_record.blue_cluster_internal_clb.*.fqdn, aws_route53_record.green_cluster_internal_clb.*.fqdn, list("")), 0)}"
}

output "internal_clb_weighted_dns_name" {
  value = "${element(coalescelist(aws_route53_record.blue_cluster_internal_clb.*.name, aws_route53_record.green_cluster_internal_clb.*.name, list("")), 0)}"
}

########
# BLUE
########

output "blue_internal_clb_dns_name" {
  value = "${module.blue_cluster_internal_clb.dns_name}"
}

# output "blue_internal_clb_load_balancer_arn_suffix" {
#   value = "${module.blue_cluster_internal_clb.load_balancer_arn_suffix}"
# }

output "blue_internal_clb_load_balancer_id" {
  value = "${module.blue_cluster_internal_clb.load_balancer_id}"
}

output "blue_internal_clb_load_balancer_zone_id" {
  value = "${module.blue_cluster_internal_clb.load_balancer_zone_id}"
}

output "blue_internal_clb_load_balancer_arns" {
  value = "${module.blue_cluster_internal_clb.load_balancer_arns}"
}

########
# GREEN
########

output "green_internal_clb_dns_name" {
  value = "${module.green_cluster_internal_clb.dns_name}"
}

# output "green_internal_clb_load_balancer_arn_suffix" {
#   value = "${module.green_cluster_internal_clb.load_balancer_arn_suffix}"
# }

output "green_internal_clb_load_balancer_id" {
  value = "${module.green_cluster_internal_clb.load_balancer_id}"
}

output "green_internal_clb_load_balancer_zone_id" {
  value = "${module.green_cluster_internal_clb.load_balancer_zone_id}"
}

output "green_internal_clb_load_balancer_arns" {
  value = "${module.green_cluster_internal_clb.load_balancer_arns}"
}
