#####
# DNS
#####

output "internal_elb_weighted_fqdn" {
  value = "${element(coalescelist(aws_route53_record.blue_cluster_internal_elb.*.fqdn, aws_route53_record.green_cluster_internal_elb.*.fqdn, list("")), 0)}"
}

output "internal_elb_weighted_dns_name" {
  value = "${element(coalescelist(aws_route53_record.blue_cluster_internal_elb.*.name, aws_route53_record.green_cluster_internal_elb.*.name, list("")), 0)}"
}

########
# BLUE
########

output "blue_internal_elb_dns_name" {
  value = "${module.blue_cluster_internal_elb.dns_name}"
}

# output "blue_internal_elb_load_balancer_arn_suffix" {
#   value = "${module.blue_cluster_internal_elb.load_balancer_arn_suffix}"
# }

output "blue_internal_elb_load_balancer_id" {
  value = "${module.blue_cluster_internal_elb.id}"
}

output "blue_internal_elb_load_balancer_zone_id" {
  value = "${module.blue_cluster_internal_elb.zone_id}"
}

output "blue_internal_elb_load_balancer_arn" {
  value = "${module.blue_cluster_internal_elb.arn}"
}

########
# GREEN
########

output "green_internal_elb_dns_name" {
  value = "${module.green_cluster_internal_elb.dns_name}"
}

# output "green_internal_elb_load_balancer_arn_suffix" {
#   value = "${module.green_cluster_internal_elb.load_balancer_arn_suffix}"
# }

output "green_internal_elb_load_balancer_id" {
  value = "${module.green_cluster_internal_elb.id}"
}

output "green_internal_elb_load_balancer_zone_id" {
  value = "${module.green_cluster_internal_elb.zone_id}"
}

output "green_internal_elb_load_balancer_arn" {
  value = "${module.green_cluster_internal_elb.arn}"
}
