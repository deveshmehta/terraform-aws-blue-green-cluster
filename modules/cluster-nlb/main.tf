##################################################################################
# NLB
##################################################################################
module "cluster_nlb" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-alb.git?ref=feature/nlb-support-with-enabled-option"
  # source = "../../../cmg-terraform-aws-alb"

  enabled = "${var.enabled}"

  load_balancer_type               = "network"

  load_balancer_name               = "${var.cluster_name}-${var.color}-${var.load_balancer_is_internal ? "int" : "ext"}-nlb"
  load_balancer_is_internal        = "${var.load_balancer_is_internal}"

  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false

  log_bucket_name     = "${var.log_bucket_name}"
  log_location_prefix = "${var.cluster_name}-${var.color}-${var.load_balancer_is_internal ? "internal" : "external"}-nlb-logs"
  subnets             = "${split(",", var.subnets)}"

  tags = "${map(
    "Environment", "${terraform.workspace}",
    "Workspace", "${terraform.workspace}",
    "Product", "${var.product}",
    "Product Family", "${var.product_family}",
    "Role", "${var.role}",
    "Costcode", "${var.cost_code}",
    "Owner", "${var.owner}",
    "Version", "${var.version_tag}",
    "Scheme", "${var.load_balancer_is_internal ? "Internal" : "External"}",
    "Terraform", "True",
    "Persistence", "false"
  )}"

  vpc_id = "${var.vpc_id}"

  https_listeners_count = "${var.https_listeners_count}"
  https_listeners       = "${var.https_listeners}"

  http_tcp_listeners_count = "${var.http_tcp_listeners_count}"
  http_tcp_listeners       = "${var.http_tcp_listeners}"

  target_groups_count = "${var.target_groups_count}"
  target_groups = "${var.target_groups}"
}

##################################################################################
# ALB Route53 Resource
##################################################################################

module "cluster_nlb_route53_aliases" {
  enabled         = "${var.enabled ? "true" : "false"}"

  source          = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-route53-alias.git"
  aliases         = "${var.route53_aliases_name}"
  parent_zone_id  = "${var.route53_zone_id}"
  target_dns_name = "${module.cluster_nlb.dns_name}"
  target_zone_id  = "${module.cluster_nlb.load_balancer_zone_id}"
}