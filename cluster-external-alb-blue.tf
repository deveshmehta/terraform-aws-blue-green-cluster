module "blue_cluster_external_alb" {
  source = "./modules/cluster-alb"

  enabled = "${var.external_alb_enabled}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.external_alb_subnet_ids}"

  cluster_name = "${var.cluster_name}"
  color        = "blue"

  security_groups = "${var.external_alb_security_groups}"

  load_balancer_is_internal = false

  computed_ingress_with_source_security_group_id           = "${var.external_alb_computed_ingress_with_source_security_group_id}"
  number_of_computed_ingress_with_source_security_group_id = "${var.external_alb_number_of_computed_ingress_with_source_security_group_id}"

  computed_ingress_with_cidr_blocks           = "${var.external_alb_computed_ingress_with_cidr_blocks}"
  number_of_computed_ingress_with_cidr_blocks = "${var.external_alb_number_of_computed_ingress_with_cidr_blocks}"

  number_of_computed_egress_with_source_security_group_id = "${var.external_alb_number_of_computed_egress_with_source_security_group_id}"
  computed_egress_with_source_security_group_id           = "${var.external_alb_computed_egress_with_source_security_group_id}"

  computed_egress_with_cidr_blocks           = "${var.external_alb_computed_egress_with_cidr_blocks}"
  number_of_computed_egress_with_cidr_blocks = "${var.external_alb_number_of_computed_egress_with_cidr_blocks}"

  application_ports = "${var.blue_application_ports}"
  application_security_group_id = "${module.cluster_sg.this_security_group_id}"

  log_bucket_name = "${aws_s3_bucket.log_bucket.id}"

  product        = "${var.product}"
  product_family = "${var.product_family}"
  role           = "${var.role} EXTERNAL BLUE"
  cost_code      = "${var.cost_code}"
  owner          = "${var.owner}"
  version_tag    = "${var.blue_version_tag}"

  https_listeners_count = "${var.blue_alb_https_listeners_count}"
  https_listeners       = "${var.blue_alb_https_listeners}"

  http_tcp_listeners_count = "${var.blue_alb_http_tcp_listeners_count}"
  http_tcp_listeners       = "${var.blue_alb_http_tcp_listeners}"

  target_groups_count = "${var.blue_external_alb_target_groups_count}"
  target_groups       = "${var.blue_external_alb_target_groups}"

  route53_aliases_name = ["${var.cluster_name}-external-alb-blue"]
  route53_zone_id      = "${var.external_alb_route53_zone_id}"
}

resource "aws_route53_record" "blue_cluster_external_alb" {
  count = "${var.external_alb_enabled ? 1 : 0}"

  name    = "${var.cluster_name}-external-alb"
  zone_id = "${var.external_alb_route53_zone_id}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.blue_weight}"
  }

  set_identifier = "Primary"
  records        = ["${module.blue_cluster_external_alb.dns_name}"]
}
