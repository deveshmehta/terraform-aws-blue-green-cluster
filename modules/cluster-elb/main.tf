data "aws_elb_service_account" "main" {}

data "aws_caller_identity" "current" {}

locals {
  name = "${var.cluster_name}-${var.color}-int-elb"
}

resource "aws_elb" "elb" {
  count = "${var.enabled ? 1 : 0}"

  name                = "${local.name}"

  subnets             = ["${var.subnet_ids}"]
  internal            = true


  security_groups     = [
    "${module.elb_security_group.this_security_group_id}"
  ]

  access_logs = [
    {
      bucket        = "${aws_s3_bucket.elb_log_bucket.id}",
      bucket_prefix = "logs"
    }
  ]

  listener = [
    {
      instance_port      = "443"
      instance_protocol  = "TCP"
      lb_port            = "443"
      lb_protocol        = "TCP"
    }
  ]

  health_check = [
    {
      target              = "SSL:443"
      interval            = 30
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
    }
  ]

  tags = {
    Environment      = "${terraform.workspace}"
    Workspace        = "${terraform.workspace}"
    Application      = "${var.product}"
    Product          = "${var.product}"
    "Product Family" = "${var.product_family}"
    Costcode         = "${var.cost_code}"
    Owner            = "${var.owner}"
    Role             = "${var.role}"
    Terraform        = "True"
    Persistence      = "false"
  }
}

resource "aws_elb_attachment" "this" {
  count = "${var.number_of_instances}"

  elb      = "${aws_elb.elb.id}"
  instance = "${element(var.instances, count.index)}"
}

data "aws_iam_policy_document" "elb_log_bucket_policy" {
  statement {
    sid = "AllowToPutLoadBalancerLogsToS3Bucket"

    actions   = [
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${local.name}-logs/logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [
        "${data.aws_elb_service_account.main.arn}"
      ]
    }
  }
}

resource "aws_s3_bucket" "elb_log_bucket" {
  bucket        = "${local.name}-logs"
  policy        = "${data.aws_iam_policy_document.elb_log_bucket_policy.json}"
  force_destroy = true

  tags = "${merge(
    map("Environment", "${terraform.workspace}"),
    var.tags
  )}"

  lifecycle_rule {
    id      = "log-expiration"
    enabled = "true"

    expiration {
      days = "7"
    }
  }
}

##################################################################################
# ELB SECURITY GROUPS
##################################################################################
module "elb_security_group" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-security-group.git"

  name         = "${local.name}-sg"
  description  = "${var.cluster_name} ELB Security Group"
  vpc_id       = "${var.vpc_id}"

  # egress_rules = ["all-all"]
  egress_cidr_blocks      = []
  egress_ipv6_cidr_blocks = []

  create = "${var.enabled}" # sg module uses `create` not `enabled` variable

  tags = "${merge(
    map("Name", "${local.name}-sg"),
    map("Environment", terraform.workspace),
    map("Scheme", "Internal"),
    var.tags
  )}"

  computed_ingress_with_source_security_group_id = "${var.computed_ingress_with_source_security_group_id}"
  number_of_computed_ingress_with_source_security_group_id = "${var.number_of_computed_ingress_with_source_security_group_id}"

  computed_ingress_with_cidr_blocks = "${var.computed_ingress_with_cidr_blocks}"
  number_of_computed_ingress_with_cidr_blocks = "${var.number_of_computed_ingress_with_cidr_blocks}"

  number_of_computed_egress_with_source_security_group_id = "${var.number_of_computed_egress_with_source_security_group_id}"
  computed_egress_with_source_security_group_id           = "${var.computed_egress_with_source_security_group_id}"

  number_of_computed_egress_with_cidr_blocks = "${var.number_of_computed_egress_with_cidr_blocks}"
  computed_egress_with_cidr_blocks           = "${var.computed_egress_with_cidr_blocks}"

}


## Add Egress rules to the ELB
resource "aws_security_group_rule" "cluster_elb_egress_to_application" {
  count = "${var.enabled ? length(var.application_ports) : 0}"

  type                     = "egress"
  from_port                = "${element(var.application_ports, count.index)}"
  to_port                  = "${element(var.application_ports, count.index)}"
  protocol                 = "tcp"
  description              = "${var.cluster_name} Application Egress"
  security_group_id        = "${module.elb_security_group.this_security_group_id}"
  source_security_group_id = "${var.application_security_group_id}"
  depends_on               = ["module.elb_security_group"]
}

##################################################################################
# ELB Route53 Resource
##################################################################################

module "cluster_elb_route53_aliases" {
  enabled = "${var.enabled ? "true" : "false"}"

  source          = "git::https://gitlab.awscmg-dev.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-route53-alias.git"
  aliases         = "${var.route53_aliases_name}"
  parent_zone_id  = "${var.route53_zone_id}"
  target_dns_name = "${aws_elb.elb.dns_name}"
  target_zone_id  = "${aws_elb.elb.zone_id}"
}