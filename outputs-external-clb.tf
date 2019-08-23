#####
# DNS
#####

# output "external_clb_weighted_fqdn" {
#   value = "${element(coalescelist(aws_route53_record.blue_cluster_external_clb.*.fqdn, aws_route53_record.green_cluster_external_clb.*.fqdn, list("")), 0)}"
# }

output "external_clb_weighted_dns_name" {
  value = "${element(coalescelist(aws_route53_record.blue_cluster_external_clb.*.name, aws_route53_record.green_cluster_external_clb.*.name, list("")), 0)}"
}

########
# BLUE
########

output "blue_external_clb_dns_name" {
  value = "${module.blue_cluster_external_clb.dns_name}"
}

# output "blue_external_clb_load_balancer_arn_suffix" {
#   value = "${module.blue_cluster_external_clb.load_balancer_arn_suffix}"
# }

output "blue_external_clb_load_balancer_id" {
  value = "${module.blue_cluster_external_clb.load_balancer_id}"
}

output "blue_external_clb_load_balancer_zone_id" {
  value = "${module.blue_cluster_external_clb.load_balancer_zone_id}"
}

output "blue_external_clb_load_balancer_arns" {
  value = "${module.blue_cluster_external_clb.load_balancer_arns}"
}

########
# GREEN
########

output "green_external_clb_dns_name" {
  value = "${module.green_cluster_external_clb.dns_name}"
}

# output "green_external_clb_load_balancer_arn_suffix" {
#   value = "${module.green_cluster_external_clb.load_balancer_arn_suffix}"
# }

output "green_external_clb_load_balancer_id" {
  value = "${module.green_cluster_external_clb.load_balancer_id}"
}

output "green_external_clb_load_balancer_zone_id" {
  value = "${module.green_cluster_external_clb.load_balancer_zone_id}"
}

output "green_external_clb_load_balancer_arns" {
  value = "${module.green_cluster_external_clb.load_balancer_arns}"
}
