##################################################################################
# Options App ALB SECURITY GROUPS
##################################################################################
module "cluster_alb_sg" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-security-group.git"

  name        = "${var.cluster_alb_sg_name}"
  description = "${var.cluster_alb_sg_description}"
  vpc_id      = "${var.vpc_id}"
  egress_rules  = ["all-all"]

  number_of_computed_ingress_with_source_security_group_id = 2
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "https-443-tcp"
      description              = "HTTPS Traffic Inbound"
      source_security_group_id = "${var.proxy_sg_id}"
    },
    {
      from_port                = "${var.application_traffic_port}"
      to_port                  = "${var.application_traffic_port}"
      protocol                 = 6
      description              = "Application Traffic Inbound"
      source_security_group_id = "${var.proxy_sg_id}"
    }
  ]

  number_of_computed_ingress_with_cidr_blocks = 2
  computed_ingress_with_cidr_blocks = [
    {
      rule        = "https-443-tcp"
      description = "HTTPS Traffic Inbound"
      cidr_blocks = "${join(",", var.alb_ingress_cidr_blocks)}"
    },
    {
      from_port   = "${var.application_traffic_port}"
      to_port     = "${var.application_traffic_port}"
      protocol    = 6
      description = "Application Traffic Inbound from Subnet"
      cidr_blocks = "${join(",", var.alb_ingress_cidr_blocks)}"
    }
  ]

  number_of_computed_egress_with_source_security_group_id = 1
  computed_egress_with_source_security_group_id = [
    {
      from_port                = "${var.application_traffic_port}"
      to_port                  = "${var.application_traffic_port}"
      protocol                 = 6
      description              = "Application Traffic Outbound"
      source_security_group_id = "${var.proxy_sg_id}"
    }
  ]

  tags = {
    Environment      = "${terraform.workspace}"
    Workspace        = "${terraform.workspace}"
    Product          = "${var.product}"
    "Product Family" = "${var.product_family}"
    Costcode         = "${var.cost_code}"
    Owner            = "${var.owner}"
    Role             = "${var.role}"
    Terraform        = "True"
  }
}

##################################################################################
# S3 for Options App ALB logs
##################################################################################

resource "aws_s3_bucket" "log_bucket" {
  bucket        = "${var.cluster_alb_log_bucket_name}"
  policy        = "${data.aws_iam_policy_document.cluster_alb_log_bucket_policy.json}"
  force_destroy = true

  tags = "${map("Environment", "${terraform.workspace}",
                    "load_balancer_is_internal", "True",
                    "Workspace", "${terraform.workspace}",
                    "Terraform", "True",
                    "Product", "${var.product}",
                    "Product Family", "${var.product_family}",
                    "Costcode", "${var.cost_code}",
                    "Owner", "${var.owner}",
                    "Role" , "Store ALB Logs",
                    "Version" , "0.1.0",
                    "Persistence", "true"
                  )}"

  lifecycle_rule {
    id      = "log-expiration"
    enabled = "true"

    expiration {
      days = "7"
    }
  }
}

##################################################################################
# Options App ALB Primary
##################################################################################
module "cluster_alb_1" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-alb.git?ref=feature/nlb-support"
  # source = "../cmg-terraform-aws-alb"

  load_balancer_type = "network"
  load_balancer_name        = "${var.cluster_alb_1_name}"
  load_balancer_is_internal = "true"
  # security_groups           = ["${module.cluster_alb_sg.this_security_group_id}"]
  enable_cross_zone_load_balancing = "true"
  enable_deletion_protection = "true"

  log_bucket_name     = "${aws_s3_bucket.log_bucket.id}"
  log_location_prefix = "${var.cluster_alb_1_name}-logs"
  subnets             = "${var.public_subnets}"

  tags = "${map(
              "Environment", "${terraform.workspace}",
              "Workspace", "${terraform.workspace}",
              "Terraform", "True",
              "Scheme", "${var.cluster_alb_schema}",
              "Product", "${var.product}",
              "Product Family", "${var.product_family}",
              "Costcode", "${var.cost_code}",
              "Owner", "${var.owner}",
              "Role", "${var.role}",
              "Version", "${var.version_tag}",
              "Persistence", "true"
            )}"

  vpc_id = "${var.vpc_id}"

  # https_listeners_count = 1
  # https_listeners = "${list(
  #                       map(
  #                           "certificate_arn", "${var.alb_certificate_arn}",
  #                           "port", 443,
  #                       )
  #                     )}"



  http_tcp_listeners_count = 1
  http_tcp_listeners       = "${list(
                                map(
                                    "port", "${var.application_traffic_port}",
                                    "protocol", "TCP"
                                )
                              )}"

  target_groups_count = 1
  target_groups = "${list(
                      map("name", "${var.cluster_alb_1_name}-tg",
                        "backend_protocol", "TCP",
                        "backend_port", "${var.application_traffic_port}",
                        "health_check_path", "",
                        "stickiness_enabled", "false",
                      )
                    )}"

}

##################################################################################
# Options App Route53 Resource Primary
##################################################################################

module "cluster_alb_1_route53_aliases" {
  source          = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-route53-alias.git"
  aliases         = "${var.cluster_alb_1_route53_aliases_name}"
  parent_zone_id  = "${var.aws_route53_private_zone_id}"
  target_dns_name = "${module.cluster_alb_1.dns_name}"
  target_zone_id  = "${module.cluster_alb_1.load_balancer_zone_id}"
}

##################################################################################
# Options App ALB Seconday
##################################################################################
module "cluster_alb_2" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-alb.git?ref=feature/nlb-support"  # source = "../cmg-terraform-aws-alb"

  load_balancer_type = "network"
  load_balancer_name        = "${var.cluster_alb_2_name}"
  load_balancer_is_internal = "${var.alb_is_internal}"
  # security_groups           = ["${module.cluster_alb_sg.this_security_group_id}"]
  enable_cross_zone_load_balancing = "true"
  enable_deletion_protection = "true"

  log_bucket_name     = "${aws_s3_bucket.log_bucket.id}"
  log_location_prefix = "${var.cluster_alb_2_name}-logs"
  subnets             = "${var.public_subnets}"

  tags = "${map("Environment", "${terraform.workspace}",
                    "Workspace", "${terraform.workspace}",
                    "Terraform", "True",
                    "Scheme", "${var.cluster_alb_schema}",
                    "Product", "${var.product}",
                    "Product Family", "${var.product_family}",
                    "Costcode", "${var.cost_code}",
                    "Owner", "${var.owner}",
                    "Role", "App Server",
                    "Version", "0.1.0",
                    "Persistence", "true"
                    )}"

  vpc_id = "${var.vpc_id}"

  # https_listeners_count = 1
  # https_listeners = "${list(
  #                       map(
  #                           "certificate_arn", "${var.alb_certificate_arn}",
  #                           "port", 443,
  #                       )
  #                     )}"


  http_tcp_listeners_count = 1
  http_tcp_listeners       = "${list(
                                map(
                                    "port", "${var.application_traffic_port}",
                                    "protocol", "TCP"
                                )
                              )}"

  target_groups_count = 1
  target_groups = "${list(
                      map("name", "${var.cluster_alb_2_name}-tg",
                        "backend_protocol", "TCP",
                        "backend_port", "${var.application_traffic_port}",
                        "stickiness_enabled", "false",
                      )
                    )}"


  # https_listeners          = "${local.https_listeners}"
  # https_listeners_count    = "${local.https_listeners_count}"
  # http_tcp_listeners       = "${local.http_tcp_listeners}"
  # http_tcp_listeners_count = "${local.http_tcp_listeners_count}"
  # target_groups            = "${local.target_groups}"
  # target_groups_count      = "${local.target_groups_count}"
}

##################################################################################
# Options App Route53 Resource Secondary
##################################################################################

module "cluster_alb_2_route53_aliases" {
  source          = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-route53-alias.git"
  aliases         = "${var.cluster_alb_2_route53_aliases_name}"
  parent_zone_id  = "${var.aws_route53_private_zone_id}"
  target_dns_name = "${module.cluster_alb_2.dns_name}"
  target_zone_id  = "${module.cluster_alb_2.load_balancer_zone_id}"
}
