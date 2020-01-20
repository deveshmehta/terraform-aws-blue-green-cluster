##################################################################################
# Options SECURITY GROUPS
##################################################################################
module "cluster_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.cluster_name}-sg"
  description = "${var.cluster_name} Security Group"
  vpc_id      = "${var.vpc_id}"

  # egress_rules = ["all-all"]
  egress_cidr_blocks      = []
  egress_ipv6_cidr_blocks = []

  number_of_computed_ingress_with_source_security_group_id = "${var.instance_number_of_computed_ingress_with_source_security_group_id}"
  computed_ingress_with_source_security_group_id           = "${var.instance_computed_ingress_with_source_security_group_id}"

  number_of_computed_ingress_with_cidr_blocks = "${var.instance_number_of_computed_ingress_with_cidr_blocks}"
  computed_ingress_with_cidr_blocks           = "${var.instance_computed_ingress_with_cidr_blocks}"

  number_of_computed_egress_with_source_security_group_id = "${var.instance_number_of_computed_egress_with_source_security_group_id}"
  computed_egress_with_source_security_group_id           = "${var.instance_computed_egress_with_source_security_group_id}"

  number_of_computed_egress_with_cidr_blocks = "${var.instance_number_of_computed_egress_with_cidr_blocks}"
  computed_egress_with_cidr_blocks           = "${var.instance_computed_egress_with_cidr_blocks}"

  tags = {
    Environment      = "${terraform.workspace}"
    Workspace        = "${terraform.workspace}"
    Application      = "${var.product}"
    Product          = "${var.product}"
    "Product Family" = "${var.product_family}"
    Costcode         = "${var.cost_code}"
    Owner            = "${var.owner}"
    Role             = "${var.role}"
    Persistence      = "true"
    Terraform        = "True"
  }
}

resource "aws_security_group_rule" "cluster_sg_ingress_from_blue_internal_alb" {
  count = "${var.internal_alb_enabled ? length(var.blue_application_ports) : 0}"

  type                     = "ingress"
  from_port                = "${element(var.blue_application_ports, count.index)}"
  to_port                  = "${element(var.blue_application_ports, count.index)}"
  protocol                 = "tcp"
  description              = "${var.cluster_name} Internal Blue ALB"
  security_group_id        = "${module.cluster_sg.this_security_group_id}"
  source_security_group_id = "${module.blue_cluster_internal_alb.security_group_id}"
  depends_on               = ["module.blue_cluster_internal_alb"]
}

resource "aws_security_group_rule" "cluster_sg_ingress_from_green_internal_alb" {
  count = "${var.internal_alb_enabled ? length(var.green_application_ports) : 0}"

  type                     = "ingress"
  from_port                = "${element(var.green_application_ports, count.index)}"
  to_port                  = "${element(var.green_application_ports, count.index)}"
  protocol                 = "tcp"
  description              = "${var.cluster_name} Internal Green ALB"
  security_group_id        = "${module.cluster_sg.this_security_group_id}"
  source_security_group_id = "${module.green_cluster_internal_alb.security_group_id}"
  depends_on               = ["module.green_cluster_internal_alb"]
}

resource "aws_security_group_rule" "cluster_sg_ingress_from_blue_external_alb" {
  count = "${var.external_alb_enabled ? length(var.blue_application_ports) : 0}"

  type                     = "ingress"
  from_port                = "${element(var.blue_application_ports, count.index)}"
  to_port                  = "${element(var.blue_application_ports, count.index)}"
  protocol                 = "tcp"
  description              = "${var.cluster_name} External Blue ALB"
  security_group_id        = "${module.cluster_sg.this_security_group_id}"
  source_security_group_id = "${module.blue_cluster_external_alb.security_group_id}"
  depends_on               = ["module.blue_cluster_external_alb"]
}

resource "aws_security_group_rule" "cluster_sg_ingress_from_green_external_alb" {
  count = "${var.external_alb_enabled ? length(var.green_application_ports) : 0}"

  type                     = "ingress"
  from_port                = "${element(var.green_application_ports, count.index)}"
  to_port                  = "${element(var.green_application_ports, count.index)}"
  protocol                 = "tcp"
  description              = "${var.cluster_name} External Green ALB"
  security_group_id        = "${module.cluster_sg.this_security_group_id}"
  source_security_group_id = "${module.green_cluster_external_alb.security_group_id}"
  depends_on               = ["module.green_cluster_external_alb"]
}

resource "aws_security_group_rule" "cluster_sg_egress_to_cloudwatch_vpc_endpoint" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  description              = "${var.cluster_name} Cloudwatch Logs VPC Endpoint"
  security_group_id        = "${module.cluster_sg.this_security_group_id}"
  source_security_group_id = "${data.aws_security_group.cloudwatch_vpc_endpoint_sg.id}"
  depends_on               = ["module.cluster_sg"]
}

resource "aws_security_group_rule" "cluster_sg_ingress_from_blue_internal_elb" {
  count = "${var.internal_elb_enabled ? length(var.blue_application_ports) : 0}"

  type                     = "ingress"
  from_port                = "${element(var.blue_application_ports, count.index)}"
  to_port                  = "${element(var.blue_application_ports, count.index)}"
  protocol                 = "tcp"
  description              = "${var.cluster_name} Internal Blue ELB"
  security_group_id        = "${module.cluster_sg.this_security_group_id}"
  source_security_group_id = "${module.blue_cluster_internal_elb.security_group_id}"
  depends_on               = ["module.blue_cluster_internal_elb"]
}

resource "aws_security_group_rule" "cluster_sg_ingress_from_green_internal_elb" {
  count = "${var.internal_elb_enabled ? length(var.green_application_ports) : 0}"

  type                     = "ingress"
  from_port                = "${element(var.green_application_ports, count.index)}"
  to_port                  = "${element(var.green_application_ports, count.index)}"
  protocol                 = "tcp"
  description              = "${var.cluster_name} Internal Green ELB"
  security_group_id        = "${module.cluster_sg.this_security_group_id}"
  source_security_group_id = "${module.green_cluster_internal_elb.security_group_id}"
  depends_on               = ["module.green_cluster_internal_elb"]
}