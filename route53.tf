resource "aws_route53_record" "application_frontend_primary" {
  zone_id = "${var.aws_route53_private_zone_id}"
  name    = "${var.cluster_internal_alb_route53_record}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.cluster_primary_weight}"
  }

  set_identifier = "Primary"
  records        = ["${module.cluster_alb_1.dns_name}"]
}

resource "aws_route53_record" "application_frontend_secondary" {
  zone_id = "${var.aws_route53_private_zone_id}"
  name    = "${var.cluster_internal_alb_route53_record}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = "${var.cluster_secondary_weight}"
  }

  set_identifier = "Secondary"
  records        = ["${module.cluster_alb_2.dns_name}"]
}
