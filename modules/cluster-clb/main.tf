##################################################################################
# CLB
##################################################################################
module "cluster_clb" {
  source = "git::https://gitlab.awscmg-dev.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-alb.git?ref=feature/clb-support"

  clb_enabled = "${var.enabled}"
  load_balancer_name        = "${var.cluster_name}-${var.color}-${var.load_balancer_is_internal ? "int" : "ext"}-clb"
  load_balancer_is_internal = "${var.load_balancer_is_internal}"
  enable_cross_zone_load_balancing = true
  log_bucket_name     = "${var.log_bucket_name}"
  log_location_prefix = "${var.cluster_name}-${var.color}-${var.load_balancer_is_internal ? "internal" : "external"}-clb-logs"
  subnets             = "${split(",", var.subnets)}"
  tags = "${map(
    "Environment", "${terraform.workspace}",
    "Workspace", "${terraform.workspace}",
    "Application", "${var.product}",
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
  clb_health_check    = "${var.clb_health_check}"
  clb_listeners       = "${var.clb_listeners}"
}

##################################################################################
# ALB Route53 Resource
##################################################################################

module "cluster_clb_route53_aliases" {
  clb_enabled = "${var.enabled ? "true" : "false"}"

  source          = "git::https://gitlab.awscmg-dev.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-route53-alias.git"
  aliases         = "${var.route53_aliases_name}"
  parent_zone_id  = "${var.route53_zone_id}"
  target_dns_name = "${module.cluster_clb.dns_name}"
  target_zone_id  = "${module.cluster_clb.load_balancer_zone_id}"
}
