module "green_cluster_internal_alb" {
  source = "./modules/cluster-alb"

  enabled = "${var.internal_alb_enabled}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.internal_alb_subnet_ids}"

  cluster_name = "${var.cluster_name}"
  color = "green"

  security_groups = "${var.internal_alb_security_groups}"

  load_balancer_is_internal = true

  computed_ingress_with_source_security_group_id           = "${var.internal_alb_computed_ingress_with_source_security_group_id}"
  number_of_computed_ingress_with_source_security_group_id = "${var.internal_alb_number_of_computed_ingress_with_source_security_group_id}"

  computed_ingress_with_cidr_blocks           = "${var.internal_alb_computed_ingress_with_cidr_blocks}"
  number_of_computed_ingress_with_cidr_blocks = "${var.internal_alb_number_of_computed_ingress_with_cidr_blocks}"

  number_of_computed_egress_with_source_security_group_id = "${var.internal_alb_number_of_computed_egress_with_source_security_group_id}"
  computed_egress_with_source_security_group_id           = "${var.internal_alb_computed_egress_with_source_security_group_id}"

  computed_egress_with_cidr_blocks           = "${var.internal_alb_computed_egress_with_cidr_blocks}"
  number_of_computed_egress_with_cidr_blocks = "${var.internal_alb_number_of_computed_egress_with_cidr_blocks}"

  log_bucket_name = "${aws_s3_bucket.log_bucket.id}"

  product         = "${var.product}"
  product_family  = "${var.product_family}"
  role            = "${var.role} INTERNAL GREEN"
  cost_code       = "${var.cost_code}"
  owner           = "${var.owner}"
  version_tag     = "${var.green_version_tag}"

  https_listeners_count = "${var.green_alb_https_listeners_count}"
  https_listeners       = "${var.green_alb_https_listeners}"

  http_tcp_listeners_count = "${var.green_alb_http_tcp_listeners_count}"
  http_tcp_listeners       = "${var.green_alb_http_tcp_listeners}"

  target_groups_count = "${var.green_internal_alb_target_groups_count}"
  target_groups       = "${var.green_internal_alb_target_groups}"

  route53_aliases_name = ["${var.cluster_name}-internal-alb-green"]
  route53_zone_id      = "${var.internal_alb_route53_zone_id}"
}

resource "aws_route53_record" "green_cluster_internal_alb" {
  count = "${var.internal_alb_enabled ? 1 : 0}"

  name = "${var.cluster_name}-internal-alb"

  zone_id = "${var.internal_alb_route53_zone_id}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.green_weight}"
  }

  set_identifier = "Secondary"
  records        = ["${module.green_cluster_internal_alb.dns_name}"]
}