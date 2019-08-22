##################################################################################
# Options ASG Resource Primary
##################################################################################
module "green_cluster_asg" {
  source = "./modules/cluster-asg"

  cluster_name = "${var.cluster_name}"
  color        = "green"

  image_id      = "${var.green_image_id}"
  instance_type = "${var.green_instance_type}"
  ssh_key_name  = "${var.ssh_key_name}"
  user_data     = "${var.user_data}"

  security_groups = [
    "${module.cluster_sg.this_security_group_id}",
    "${var.instance_security_groups}",
  ]

  target_group_arns = [
    "${element(concat(module.green_cluster_internal_alb.target_group_arns, module.green_cluster_internal_nlb.target_group_arns, list("")), 0)}",
    "${element(concat(module.green_cluster_external_alb.target_group_arns, module.green_cluster_external_nlb.target_group_arns, list("")), 0)}",
  ]

  load_balancers_arns = [
    "${element(concat(module.green_cluster_internal_clb.load_balancer_arns, module.green_cluster_internal_clb.load_balancer_arns, list("")), 0)}",
    "${element(concat(module.green_cluster_external_clb.load_balancer_arns, module.green_cluster_external_clb.load_balancer_arns, list("")), 0)}",
  ]

  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.arn}"

  # Auto scaling group
  subnet_ids = "${var.instance_subnet_ids}"

  min_size                  = "${var.green_min_size}"
  max_size                  = "${var.green_max_size}"
  desired_capacity          = "${var.green_desired_capacity}"
  wait_for_capacity_timeout = "${var.green_wait_for_capacity_timeout}"

  min_size_start         = "${var.green_min_size_start}"
  max_size_start         = "${var.green_max_size_start}"
  desired_capacity_start = "${var.green_desired_capacity_start}"
  recurrence_start       = "${var.green_recurrence_start}"

  min_size_stop         = "${var.green_min_size_stop}"
  max_size_stop         = "${var.green_max_size_stop}"
  desired_capacity_stop = "${var.green_desired_capacity_stop}"
  recurrence_stop       = "${var.green_recurrence_stop}"

  product        = "${var.product}"
  product_family = "${var.product_family}"
  role           = "${var.role} GREEN"
  cost_code      = "${var.cost_code}"
  owner          = "${var.owner}"
  version_tag    = "${var.green_version_tag}"
}
