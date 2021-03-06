
module "blue_cluster_internal_elb" {
  source = "./modules/cluster-elb"

  vpc_id     = "${var.vpc_id}"
  subnet_ids = ["${var.instance_subnet_ids}"]

  cluster_name = "${var.cluster_name}"

  color        = "blue"

  elb_enabled = "${var.internal_elb_enabled}"

  elb_health_check_target_port = "${var.elb_health_check_target_port}"

  route53_domain_name = "${var.internal_alb_route53_zone_id}"

  route53_zone_id      = "${var.internal_alb_route53_zone_id}"

  route53_aliases_name = ["${var.cluster_name}-internal-elb-blue"]

  ssl_certificate     = "${var.blue_certificate_arn}"

  idle_timeout = "${var.internal_elb_idle_timeout}"

  # Public access
  computed_ingress_with_source_security_group_id = "${var.internal_alb_computed_ingress_with_source_security_group_id}"
  number_of_computed_ingress_with_source_security_group_id = "${var.internal_alb_number_of_computed_ingress_with_source_security_group_id}"

  computed_ingress_with_cidr_blocks = [    {
      rule        = "https-443-tcp"
      cidr_blocks = "10.0.0.0/8"
    },
  ]
  number_of_computed_ingress_with_cidr_blocks = "1"

  number_of_computed_egress_with_source_security_group_id = "${var.external_alb_number_of_computed_egress_with_source_security_group_id}"
  computed_egress_with_source_security_group_id           = "${var.external_alb_computed_egress_with_source_security_group_id}"

  computed_egress_with_cidr_blocks           = "${var.external_alb_computed_egress_with_cidr_blocks}"
  number_of_computed_egress_with_cidr_blocks = "${var.external_alb_number_of_computed_egress_with_cidr_blocks}"


  application_ports             = "${var.blue_application_ports}"
  application_security_group_id = "${module.cluster_sg.this_security_group_id}"

  product        = "${var.product}"
  product_family = "${var.product_family}"
  role           = "${var.role} INTERNAL BLUE"
  cost_code      = "${var.cost_code}"
  owner          = "${var.owner}"
  version_tag    = "${var.blue_version_tag}"
}


# ---------------------------------------------------------------------------------------------------------------------
# ATTACH ASG INSTANCES TO THE ELB
# ---------------------------------------------------------------------------------------------------------------------
# resource "aws_autoscaling_attachment" "blue_asg_attachment" {
#   autoscaling_group_name  = "${module.blue_cluster_asg.this_autoscaling_group_id}"
#   elb                     = "${module.blue_cluster_internal_elb.id[0]}"

#   depends_on = [
#     "module.blue_cluster_internal_elb",
#     "module.blue_cluster_asg"
#   ]
# }

##################################################################################
# ELB Route53 Resource
##################################################################################
resource "aws_route53_record" "blue_cluster_internal_elb" {
  count = "${var.internal_elb_enabled ? 1 : 0}"

  name = "${var.cluster_name}-internal-elb"

  zone_id = "${var.internal_alb_route53_zone_id}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.blue_weight}"
  }

  set_identifier = "Primary"
  records        = ["${module.blue_cluster_internal_elb.dns_name}"]
}
