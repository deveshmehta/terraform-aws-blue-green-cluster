##################################################################################
# ALB SECURITY GROUPS
##################################################################################
module "cluster_alb_sg" {
  source = "git::https://gitlab.awscmg-dev.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-security-group.git"

  name        = "${var.cluster_name}-${var.color}-${var.load_balancer_is_internal ? "internal" : "external"}-alb-sg"
  description = "${var.cluster_name} ${var.color} ALB Security Group"
  vpc_id      = "${var.vpc_id}"

  # egress_rules = ["all-all"]
  egress_cidr_blocks = []
  egress_ipv6_cidr_blocks = []

  create = "${var.enabled}" # sg module uses `create` not `enabled` variable

  computed_ingress_with_source_security_group_id           = "${var.computed_ingress_with_source_security_group_id}"
  number_of_computed_ingress_with_source_security_group_id = "${var.number_of_computed_ingress_with_source_security_group_id}"

  number_of_computed_ingress_with_cidr_blocks = "${var.number_of_computed_ingress_with_cidr_blocks}"
  computed_ingress_with_cidr_blocks           = "${var.computed_ingress_with_cidr_blocks}"

  number_of_computed_egress_with_source_security_group_id = "${var.number_of_computed_egress_with_source_security_group_id}"
  computed_egress_with_source_security_group_id           = "${var.computed_egress_with_source_security_group_id}"

  number_of_computed_egress_with_cidr_blocks = "${var.number_of_computed_egress_with_cidr_blocks}"
  computed_egress_with_cidr_blocks           = "${var.computed_egress_with_cidr_blocks}"

  tags = {
    Environment      = "${terraform.workspace}"
    Workspace        = "${terraform.workspace}"
    Product          = "${var.product}"
    "Product Family" = "${var.product_family}"
    Costcode         = "${var.cost_code}"
    Owner            = "${var.owner}"
    Role             = "${var.role}"
    Terraform        = "True"
    Persistence      = "false"
  }
}

## Add Egress rules to the ALB
resource "aws_security_group_rule" "cluster_alb_egress_to_application" {
  count = "${var.enabled ? length(var.application_ports) : 0}"

  type                     = "egress"
  from_port                = "${element(var.application_ports, count.index)}"
  to_port                  = "${element(var.application_ports, count.index)}"
  protocol                 = "tcp"
  description              = "${var.cluster_name} Application Egress"
  security_group_id        = "${module.cluster_alb_sg.this_security_group_id}"
  source_security_group_id = "${var.application_security_group_id}"
  depends_on               = ["module.cluster_alb_sg"]
}

##################################################################################
# ALB
##################################################################################
module "cluster_alb" {
  source = "git::https://gitlab.awscmg-dev.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-alb.git?ref=master"

  enabled = "${var.enabled}"

  load_balancer_name        = "${var.cluster_name}-${var.color}-${var.load_balancer_is_internal ? "int" : "ext"}-alb"
  load_balancer_is_internal = "${var.load_balancer_is_internal}"

  security_groups = [
    "${module.cluster_alb_sg.this_security_group_id}",
    "${var.security_groups}",
  ]

  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false

  # logging_enabled = false
  log_bucket_name     = "${var.log_bucket_name}"
  log_location_prefix = "${var.cluster_name}-${var.color}-${var.load_balancer_is_internal ? "internal" : "external"}-alb-logs"
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
  target_groups       = "${var.target_groups}"
}

##################################################################################
# ALB Route53 Resource
##################################################################################

module "cluster_alb_route53_aliases" {
  enabled = "${var.enabled ? "true" : "false"}"

  source          = "git::https://gitlab.awscmg-dev.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-route53-alias.git"
  aliases         = "${var.route53_aliases_name}"
  parent_zone_id  = "${var.route53_zone_id}"
  target_dns_name = "${module.cluster_alb.dns_name}"
  target_zone_id  = "${module.cluster_alb.load_balancer_zone_id}"
}
