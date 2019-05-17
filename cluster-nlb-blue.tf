module "blue_cluster_nlb" {
  source = "./modules/cluster-nlb"

  # count = "${var.nlb_enabled}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.nlb_subnet_ids}"

  cluster_name = "${var.cluster_name}"
  color = "blue"

  log_bucket_name = "${aws_s3_bucket.log_bucket.id}"

  product         = "${var.product}"
  product_family  = "${var.product_family}"
  role            = "${var.role} BLUE"
  cost_code       = "${var.cost_code}"
  owner           = "${var.owner}"
  version_tag     = "${var.version_tag}"

  https_listeners_count = "${var.blue_nlb_https_listeners_count}"
  https_listeners       = "${var.blue_nlb_https_listeners}"

  target_groups_count = "${var.blue_nlb_target_groups_count}"
  target_groups       = "${var.blue_nlb_target_groups}"

  route53_aliases_name = ["${var.cluster_name}-blue"]
  route53_zone_id = "${var.nlb_route53_zone_id}"
}

resource "aws_route53_record" "blue_cluster_nlb" {
  name = "${var.cluster_name}-nlb"

  zone_id = "${var.nlb_route53_zone_id}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.blue_weight}"
  }

  set_identifier = "Primary"
  records        = ["${module.blue_cluster_nlb.dns_name}"]
}