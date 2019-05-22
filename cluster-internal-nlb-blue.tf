module "blue_cluster_internal_nlb" {
  source = "./modules/cluster-nlb"

  enabled = "${var.internal_nlb_enabled}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.internal_nlb_subnet_ids}"

  cluster_name = "${var.cluster_name}"
  color = "blue"

  load_balancer_is_internal = true

  log_bucket_name = "${aws_s3_bucket.log_bucket.id}"

  product         = "${var.product}"
  product_family  = "${var.product_family}"
  role            = "${var.role} INTERNAL BLUE"
  cost_code       = "${var.cost_code}"
  owner           = "${var.owner}"
  version_tag     = "${var.blue_version_tag}"

  https_listeners_count = "${var.blue_nlb_https_listeners_count}"
  https_listeners       = "${var.blue_nlb_https_listeners}"

  http_tcp_listeners_count = "${var.blue_nlb_http_tcp_listeners_count}"
  http_tcp_listeners       = "${var.blue_nlb_http_tcp_listeners}"

  target_groups_count = "${var.blue_internal_nlb_target_groups_count}"
  target_groups       = "${var.blue_internal_nlb_target_groups}"

  route53_aliases_name = ["${var.cluster_name}-internal-nlb-blue"]
  route53_zone_id = "${var.internal_nlb_route53_zone_id}"
}

resource "aws_route53_record" "blue_cluster_internal_nlb" {
  count = "${var.internal_nlb_enabled ? 1 : 0}"

  name = "${var.cluster_name}-internal-nlb"

  zone_id = "${var.internal_alb_route53_zone_id}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.blue_weight}"
  }

  set_identifier = "Primary"
  records        = ["${module.blue_cluster_internal_nlb.dns_name}"]
}