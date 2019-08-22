##################################################################################
# Options ASG Resource Primary
##################################################################################
module "cluster_asg" {
  #source = "git::https://gitlab.awscmg-dev.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-autoscaling.git?ref=feature/clb_support"
  source = "git::https://gitlab.awscmg-dev.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-autoscaling.git"

  name = "${var.cluster_name}-${var.color}-svc"

  create_asg_with_initial_lifecycle_hook = true

  initial_lifecycle_hook_name                 = "${var.cluster_name}-${var.color}-asg-lifecycle-hook"
  initial_lifecycle_hook_lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
  initial_lifecycle_hook_default_result       = "CONTINUE"

  # This could be a rendered data resource
  initial_lifecycle_hook_notification_metadata = <<EOF
{

}
EOF

  # Launch configuration
  lc_name = "${var.cluster_name}-${var.color}-lc"

  image_id      = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.ssh_key_name}"
  user_data     = "${var.user_data}"

  security_groups              = ["${var.security_groups}"]
  target_group_arns            = ["${compact(flatten(var.target_group_arns))}"]  # in case any blanks...
  load_balancer_arns           = ["${compact(flatten(var.load_balancer_arns))}"] # in case any blanks...
  iam_instance_profile         = "${var.iam_instance_profile}"
  recreate_asg_when_lc_changes = true

  load_balancers = ["${var.load_balancers}"]

  # Auto scaling group
  asg_name                  = "${var.cluster_name}-${var.color}-asg"
  vpc_zone_identifier       = "${var.subnet_ids}"
  health_check_type         = "EC2"
  min_size                  = "${var.min_size}"
  max_size                  = "${var.max_size}"
  desired_capacity          = "${var.desired_capacity}"
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"

  tags_as_map = {
    Environment      = "${terraform.workspace}"
    Workspace        = "${terraform.workspace}"
    Application      = "${var.product}"
    Product          = "${var.product}"
    "Product Family" = "${var.product_family}"
    Costcode         = "${var.cost_code}"
    Owner            = "${var.owner}"
    Role             = "${var.role}"
    Version          = "${var.version_tag}"
    Persistence      = "true"
    Terraform        = "True"
  }
}

##################################################################################
# Options App ASG Schedule Resource Primary
##################################################################################
resource "aws_autoscaling_schedule" "cluster_asg_start" {
  count = "${var.recurrence_start != "false" ? 1 : 0}"

  scheduled_action_name  = "${var.cluster_name}-${var.color}-asg-start"
  min_size               = "${var.min_size_start}"
  max_size               = "${var.max_size_start}"
  desired_capacity       = "${var.desired_capacity_start}"
  recurrence             = "${var.recurrence_start}"
  autoscaling_group_name = "${module.cluster_asg.this_autoscaling_group_id}"
}

resource "aws_autoscaling_schedule" "cluster_asg_stop" {
  count = "${var.recurrence_stop != "false" ? 1 : 0}"

  scheduled_action_name  = "${var.cluster_name}-${var.color}-asg-stop"
  min_size               = "${var.min_size_stop}"
  max_size               = "${var.max_size_stop}"
  desired_capacity       = "${var.desired_capacity_stop}"
  recurrence             = "${var.recurrence_stop}"
  autoscaling_group_name = "${module.cluster_asg.this_autoscaling_group_id}"
}
