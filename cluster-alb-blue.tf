module "blue_cluster_alb" {
  source = "./modules/cluster-alb"

  enabled = "${var.alb_enabled}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.alb_subnet_ids}"

  cluster_name = "${var.cluster_name}"
  color = "blue"

  security_groups = "${var.alb_security_groups}"

  load_balancer_is_internal = "${var.alb_is_internal}"

  computed_ingress_with_source_security_group_id           = "${var.alb_computed_ingress_with_source_security_group_id}"
  number_of_computed_ingress_with_source_security_group_id = "${var.alb_number_of_computed_ingress_with_source_security_group_id}"

  computed_ingress_with_cidr_blocks           = "${var.alb_computed_ingress_with_cidr_blocks}"
  number_of_computed_ingress_with_cidr_blocks = "${var.alb_number_of_computed_ingress_with_cidr_blocks}"

  number_of_computed_egress_with_source_security_group_id = "${var.alb_number_of_computed_egress_with_source_security_group_id}"
  computed_egress_with_source_security_group_id           = "${var.alb_computed_egress_with_source_security_group_id}"

  computed_egress_with_cidr_blocks           = "${var.alb_computed_egress_with_cidr_blocks}"
  number_of_computed_egress_with_cidr_blocks = "${var.alb_number_of_computed_egress_with_cidr_blocks}"

  log_bucket_name = "${aws_s3_bucket.log_bucket.id}"

  product         = "${var.product}"
  product_family  = "${var.product_family}"
  role            = "${var.role} BLUE"
  cost_code       = "${var.cost_code}"
  owner           = "${var.owner}"
  version_tag     = "${var.blue_version_tag}"

  https_listeners_count = "${var.blue_alb_https_listeners_count}"
  https_listeners       = "${var.blue_alb_https_listeners}"

  http_tcp_listeners_count = "${var.blue_alb_http_tcp_listeners_count}"
  http_tcp_listeners       = "${var.blue_alb_http_tcp_listeners}"

  target_groups_count = "${var.blue_alb_target_groups_count}"
  target_groups       = "${var.blue_alb_target_groups}"

  route53_aliases_name = ["${var.cluster_name}-blue"]
  route53_zone_id      = "${var.alb_route53_zone_id}"
}

resource "aws_route53_record" "blue_cluster_alb" {
  count = "${var.alb_enabled ? 1 : 0}"

  name = "${var.cluster_name}-alb"
  zone_id = "${var.alb_route53_zone_id}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.blue_weight}"
  }

  set_identifier = "Primary"
  records        = ["${module.blue_cluster_alb.dns_name}"]
}