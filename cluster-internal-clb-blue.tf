module "blue_cluster_internal_clb" {
  source = "./modules/cluster-clb"

  enabled = "${var.internal_clb_enabled}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.internal_clb_subnet_ids}"

  cluster_name = "${var.cluster_name}"
  color        = "blue"

  load_balancer_is_internal = true

  log_bucket_name = "${aws_s3_bucket.log_bucket.id}"

  product        = "${var.product}"
  product_family = "${var.product_family}"
  role           = "${var.role} INTERNAL BLUE"
  cost_code      = "${var.cost_code}"
  owner          = "${var.owner}"
  version_tag    = "${var.blue_version_tag}"

  clb_listeners    = "${var.blue_clb_listeners}"
  clb_health_check = "${var.blue_clb_health_check}"

  route53_aliases_name = ["${var.cluster_name}-internal-clb-blue"]
  route53_zone_id      = "${var.internal_clb_route53_zone_id}"
}

resource "aws_route53_record" "blue_cluster_internal_clb" {
  count = "${var.internal_clb_enabled ? 1 : 0}"

  name = "${var.cluster_name}-internal-clb"

  zone_id = "${var.internal_clb_route53_zone_id}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.blue_weight}"
  }

  set_identifier = "Primary"
  records        = ["${module.blue_cluster_internal_clb.dns_name}"]
}
