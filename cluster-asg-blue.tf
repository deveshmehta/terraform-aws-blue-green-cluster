##################################################################################
# Options ASG Resource Primary
##################################################################################
module "blue_cluster_asg" {
  source = "./modules/cluster-asg"

  cluster_name = "${var.cluster_name}"
  color        = "blue"

  image_id      = "${var.blue_image_id}"
  instance_type = "${var.blue_instance_type}"
  ssh_key_name  = "${var.ssh_key_name}"

  security_groups = [
    "${module.cluster_sg.this_security_group_id}",
    "${var.instance_security_groups}"
  ]

  target_group_arns = [
    "${element(concat(module.blue_cluster_internal_alb.target_group_arns, module.blue_cluster_internal_nlb.target_group_arns, list("")), 0)}",
    "${element(concat(module.blue_cluster_external_alb.target_group_arns, module.blue_cluster_external_nlb.target_group_arns, list("")), 0)}"
  ]

  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.arn}"

  # Auto scaling group
  subnet_ids = "${var.instance_subnet_ids}"

  min_size                  = "${var.blue_min_size}"
  max_size                  = "${var.blue_max_size}"
  desired_capacity          = "${var.blue_desired_capacity}"
  wait_for_capacity_timeout = "${var.blue_wait_for_capacity_timeout}"

  min_size_start         = "${var.blue_min_size_start}"
  max_size_start         = "${var.blue_max_size_start}"
  desired_capacity_start = "${var.blue_desired_capacity_start}"
  recurrence_start       = "${var.blue_recurrence_start}"

  min_size_stop         = "${var.blue_min_size_stop}"
  max_size_stop         = "${var.blue_max_size_stop}"
  desired_capacity_stop = "${var.blue_desired_capacity_stop}"
  recurrence_stop       = "${var.blue_recurrence_stop}"

  product        = "${var.product}"   
  product_family = "${var.product_family}"
  role           = "${var.role} BLUE"
  cost_code      = "${var.cost_code}"
  owner          = "${var.owner}"
  version_tag    = "${var.blue_version_tag}"
}
