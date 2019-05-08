##################################################################################
# Options SECURITY GROUPS
##################################################################################
module "cluster_sg" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-security-group.git"

  name         = "${var.cluster_sg_name}"
  description  = "${var.cluster_sg_description}"
  vpc_id       = "${var.vpc_id}"
  egress_rules = ["all-all"]

  number_of_computed_ingress_with_source_security_group_id = 6
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      description              = "Bastion"
      source_security_group_id = "${var.bastion_sg_id}"
    },
    {
      rule                     = "ssh-tcp"
      description              = "Jenkins"
      source_security_group_id = "${var.jenkins_sg_id}"
    },
    {
      rule                     = "ssh-tcp"
      description              = "Jenkins Slave"
      source_security_group_id = "${var.jenkinsslave_sg_id}"
    },
    {
      from_port                = 9100
      to_port                  = 9100
      protocol                 = 6
      description              = "Prometheus Node Exporter"
      source_security_group_id = "${var.prometheus_sg_id}"
    },
    {
      from_port                = "${var.application_traffic_port}"
      to_port                  = "${var.application_traffic_port}"
      protocol                 = 6
      description              = "Application Traffic Inbound from ALB"
      source_security_group_id = "${module.cluster_alb_sg.this_security_group_id}"
    },
    {
      from_port                = "${var.application_traffic_port}"
      to_port                  = "${var.application_traffic_port}"
      protocol                 = 6
      description              = "Application Traffic Inbound from Proxy"
      source_security_group_id = "${var.proxy_sg_id}"
    }
  ]

  number_of_computed_ingress_with_cidr_blocks = 1
  computed_ingress_with_cidr_blocks = [
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
      description              = "Cluster Self Egress"
      source_security_group_id = "${module.cluster_sg.this_security_group_id}"
    }
  ]

  tags = {
    Terraform        = "True"
    Workspace        = "${terraform.workspace}"
    Environment      = "${terraform.workspace}"
    Product          = "${var.product}"
    "Product Family" = "${var.product_family}"
    Costcode         = "${var.cost_code}"
    Owner            = "${var.owner}"
  }
}

##################################################################################
# Options app IAM Role
##################################################################################
module "cluster_ec2_iam_role" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-ec2-iam-role.git"

  #source = "Smartbrood/ec2-iam-role/aws"
  name = "${var.cluster_ec2_iam_role_name}"

  policy_arn = [
    "${var.ec2_cmg_dm_yum_repo_s3_policy_name}",
    "${var.ec2_cmg_dm_ses_iam_policy}",
  ]
}

##################################################################################
# Options ASG Resource Primary
##################################################################################

module "cluster_asg_1" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-autoscaling.git"

  name = "${var.cluster_asg_1_service_name}"

  create_asg_with_initial_lifecycle_hook = true

  initial_lifecycle_hook_name                 = "${var.cluster_asg_1_initial_lifecycle_hook_name}"
  initial_lifecycle_hook_lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
  initial_lifecycle_hook_default_result       = "CONTINUE"

  # This could be a rendered data resource
  initial_lifecycle_hook_notification_metadata = <<EOF
{

}
EOF

  # Launch configuration
  lc_name = "${var.cluster_asg_1_lc_name}"

  image_id      = "${var.cluster_asg_1_image_id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"

  security_groups              = ["${module.cluster_sg.this_security_group_id}"]
  target_group_arns            = ["${element(module.cluster_alb_1.target_group_arns,0)}"]
  iam_instance_profile         = "${module.cluster_ec2_iam_role.profile_name}"
  recreate_asg_when_lc_changes = true

  # Auto scaling group
  asg_name                  = "${var.cluster_asg_1_name}"
  vpc_zone_identifier       = "${var.private_subnets}"
  health_check_type         = "EC2"
  min_size                  = "${var.cluster_asg_1_min_size_start}"
  max_size                  = "${var.cluster_asg_1_max_size_start}"
  desired_capacity          = "${var.cluster_asg_1_desired_capacity_start}"
  wait_for_capacity_timeout = "${var.cluster_asg_1_wait_for_capacity_timeout}"

  tags = [
    {
      key                 = "Environment"
      value               = "${terraform.workspace}"
      propagate_at_launch = true
    },
    {
      key                 = "Product"
      value               = "${var.product}"
      propagate_at_launch = true
    },
    {
      key                 = "Product Family"
      value               = "${var.product_family}"
      propagate_at_launch = true
    },
    {
      key                 = "Terraform"
      value               = "True"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    Costcode    = "${var.cost_code}"
    Owner       = "${var.owner}"
    Role        = "${var.role}"
    Version     = "${var.version_tag}"
    Persistence = "true"
  }
}

##################################################################################
# Options App ASG Schedule Resource Primary
##################################################################################
resource "aws_autoscaling_schedule" "cluster_asg_1_start" {
  scheduled_action_name  = "${var.cluster_asg_1_scheduled_action_name_start}"
  min_size               = "${var.cluster_asg_1_min_size_start}"
  max_size               = "${var.cluster_asg_1_max_size_start}"
  desired_capacity       = "${var.cluster_asg_1_desired_capacity_start}"
  recurrence             = "${var.cluster_asg_1_recurrence_start}"
  autoscaling_group_name = "${module.cluster_asg_1.this_autoscaling_group_id}"
}

resource "aws_autoscaling_schedule" "cluster_asg_1_stop" {
  scheduled_action_name  = "${var.cluster_asg_1_scheduled_action_name_stop}"
  min_size               = "${var.cluster_asg_1_min_size_stop}"
  max_size               = "${var.cluster_asg_1_max_size_stop}"
  desired_capacity       = "${var.cluster_asg_1_desired_capacity_stop}"
  recurrence             = "${var.cluster_asg_1_recurrence_stop}"
  autoscaling_group_name = "${module.cluster_asg_1.this_autoscaling_group_id}"
}

##################################################################################
# Options ASG Resource Seconday
##################################################################################

module "cluster_asg_2" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-autoscaling.git"

  name = "${var.cluster_asg_2_service_name}"

  create_asg_with_initial_lifecycle_hook = true

  initial_lifecycle_hook_name                 = "${var.cluster_asg_2_initial_lifecycle_hook_name}"
  initial_lifecycle_hook_lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
  initial_lifecycle_hook_default_result       = "CONTINUE"

  # This could be a rendered data resource
  initial_lifecycle_hook_notification_metadata = <<EOF
{

}
EOF

  # Launch configuration
  lc_name = "${var.cluster_asg_2_lc_name}"

  image_id = "${var.cluster_asg_2_image_id}"

  instance_type = "t2.micro"

  key_name = "${var.key_name}"

  security_groups              = ["${module.cluster_sg.this_security_group_id}"]
  target_group_arns            = ["${element(module.cluster_alb_2.target_group_arns,0)}"]
  iam_instance_profile         = "${module.cluster_ec2_iam_role.profile_name}"
  recreate_asg_when_lc_changes = true

  # Auto scaling group
  asg_name                  = "${var.cluster_asg_2_name}"
  vpc_zone_identifier       = "${var.private_subnets}"
  health_check_type         = "EC2"
  min_size                  = "${var.cluster_asg_2_min_size_start}"
  max_size                  = "${var.cluster_asg_2_max_size_start}"
  desired_capacity          = "${var.cluster_asg_2_desired_capacity_start}"
  wait_for_capacity_timeout = "${var.cluster_asg_2_wait_for_capacity_timeout}"

  tags = [
    {
      key                 = "Environment"
      value               = "${terraform.workspace}"
      propagate_at_launch = true
    },
    {
      key                 = "Product"
      value               = "${var.product}"
      propagate_at_launch = true
    },
    {
      key                 = "Product Family"
      value               = "${var.product_family}"
      propagate_at_launch = true
    },
    {
      key                 = "Terraform"
      value               = "True"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    Costcode    = "${var.cost_code}"
    Owner       = "${var.owner}"
    Role        = "${var.role}"
    Version     = "${var.version_tag}"
    Persistence = "true"
  }
}

##################################################################################
# Options App ASG Schedule Resource Secondary
##################################################################################
resource "aws_autoscaling_schedule" "cluster_asg_2_start" {
  scheduled_action_name  = "${var.cluster_asg_2_scheduled_action_name_start}"
  min_size               = "${var.cluster_asg_2_min_size_start}"
  max_size               = "${var.cluster_asg_2_max_size_start}"
  desired_capacity       = "${var.cluster_asg_2_desired_capacity_start}"
  recurrence             = "${var.cluster_asg_2_recurrence_start}"
  autoscaling_group_name = "${module.cluster_asg_2.this_autoscaling_group_id}"
}

resource "aws_autoscaling_schedule" "cluster_asg_2_stop" {
  scheduled_action_name  = "${var.cluster_asg_2_scheduled_action_name_stop}"
  min_size               = "${var.cluster_asg_2_min_size_stop}"
  max_size               = "${var.cluster_asg_2_max_size_stop}"
  desired_capacity       = "${var.cluster_asg_2_desired_capacity_stop}"
  recurrence             = "${var.cluster_asg_2_recurrence_stop}"
  autoscaling_group_name = "${module.cluster_asg_2.this_autoscaling_group_id}"
}
