module "green_cluster_external_clb" {
  source = "./modules/cluster-clb"

  enabled = "${var.external_clb_enabled}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.external_clb_subnet_ids}"

  cluster_name = "${var.cluster_name}"
  color        = "green"

  security_groups = "${var.external_clb_security_groups}"

  load_balancer_is_internal = false

  computed_ingress_with_source_security_group_id           = "${var.external_clb_computed_ingress_with_source_security_group_id}"
  number_of_computed_ingress_with_source_security_group_id = "${var.external_clb_number_of_computed_ingress_with_source_security_group_id}"

  computed_ingress_with_cidr_blocks           = "${var.external_clb_computed_ingress_with_cidr_blocks}"
  number_of_computed_ingress_with_cidr_blocks = "${var.external_clb_number_of_computed_ingress_with_cidr_blocks}"

  number_of_computed_egress_with_source_security_group_id = "${var.external_clb_number_of_computed_egress_with_source_security_group_id}"
  computed_egress_with_source_security_group_id           = "${var.external_clb_computed_egress_with_source_security_group_id}"

  computed_egress_with_cidr_blocks           = "${var.external_clb_computed_egress_with_cidr_blocks}"
  number_of_computed_egress_with_cidr_blocks = "${var.external_clb_number_of_computed_egress_with_cidr_blocks}"

  log_bucket_name = "${aws_s3_bucket.log_bucket.id}"

  application_ports             = "${var.green_application_ports}"
  application_security_group_id = "${module.cluster_sg.this_security_group_id}"

  product        = "${var.product}"
  product_family = "${var.product_family}"
  role           = "${var.role} EXTERNAL GREEN"
  cost_code      = "${var.cost_code}"
  owner          = "${var.owner}"
  version_tag    = "${var.green_version_tag}"

  clb_listeners    = "${var.green_clb_listeners}"
  clb_health_check = "${var.green_clb_health_check}"

  route53_aliases_name = ["${var.cluster_name}-external-clb-green"]
  route53_zone_id      = "${var.external_clb_route53_zone_id}"
}

resource "aws_route53_record" "green_cluster_external_clb" {
  count = "${var.external_clb_enabled ? 1 : 0}"

  name = "${var.cluster_name}-external-clb"

  zone_id = "${var.external_clb_route53_zone_id}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.green_weight}"
  }

  set_identifier = "Secondary"
  records        = ["${module.green_cluster_external_clb.dns_name}"]
}
