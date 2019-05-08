variable "alb_certificate_arn" {}

variable "alb_is_internal" {}

variable "mgmt_vpc_workspace" {
  default     = ""
  description = "ID of the hosted zone to contain this record  (or specify `parent_zone_name`)"
}

variable "aws_route53_private_zone_id" {

}
variable "alb_ingress_cidr_blocks" {
  description = "List of CIDR blocks to allow access from the ALB"
  type = "list"
  default = []
}

variable "route53_domain_name" {

}

variable "application_traffic_port" {
  description = "Port which the ALB sends traffic to the application over"
}

variable "cluster_log_location_prefix_1" {

}

variable "cluster_log_location_prefix_2" {

}

variable "cluster_primary_weight" {

}

variable "cluster_secondary_weight" {

}

variable "cluster_internal_alb_route53_record" {

}

variable "bastion_sg_id" {
  description = "Bastion Security Group ID"
}

variable "bastion_sg_name" {
  description = "Bastion Security Group Name"
}

variable "cluster_alb_1_name" {
  description = "Name of BLUE Cluster ALB"
}

variable "cluster_alb_1_route53_aliases_name" {
  description = "List of alb route53 aliases"
  default     = []
}

variable "cluster_alb_2_name" {
  description = "Name of GREEN Cluster ALB"
}

variable "cluster_alb_2_route53_aliases_name" {
  description = "List of alb route53 aliases"
  default     = []
}

variable "cluster_alb_log_bucket_name" {
  description = "Cluster ALB Log bucket name"
}

variable "cluster_alb_schema" {
  description = "Cluster ALB Schema Internal or External"
  default     = "Internal"
}

variable "cluster_alb_sg_description" {
  description = "Name of Options ALB Security Group"
  default     = "Cluster ALB Security Group"
}

variable "cluster_alb_sg_name" {
  description = "Name of Options ALB Security Group"
}

variable "cluster_asg_1_cpu_scaledown_alarm" {
  description = "BLUE AWG scaledown alarm name"
}

variable "cluster_asg_1_cpu_scaledown_policy" {
  description = "BLUE AWG scaledown policy"
}

variable "cluster_asg_1_cpu_scaleup_alarm" {
  description = "BLUE AWG scaleup alarm name"
}

variable "cluster_asg_1_cpu_scaleup_policy" {
  description = "BLUE AWG scaleup policy"
}

variable "cluster_asg_1_desired_capacity_start" {
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "cluster_asg_1_desired_capacity_stop" {
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "cluster_asg_1_image_id" {
  description = "Creates a unique name for launch configuration beginning with the specified prefix"
}

variable "cluster_asg_1_initial_lifecycle_hook_name" {
  description = "The name of initial lifecycle hook"
}

variable "cluster_asg_1_lc_name" {
  description = "Creates a unique name for launch configuration beginning with the specified prefix"
}

variable "cluster_asg_1_max_size_start" {
  description = "The maximum size of the auto scale group"
}

variable "cluster_asg_1_max_size_stop" {
  description = "The maximum size of the auto scale group"
}

variable "cluster_asg_1_min_size_start" {
  description = "The minimum size of the auto scale group"
}

variable "cluster_asg_1_min_size_stop" {
  description = "The minimum size of the auto scale group"
}

variable "cluster_asg_1_name" {
  description = "Creates a unique name for autoscaling group beginning with the specified prefix"
}

variable "cluster_asg_1_recurrence_start" {
  description = "The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format."
  default     = "0 07 * * MON-FRI"
}

variable "cluster_asg_1_recurrence_stop" {
  description = "The time when recurring future actions will stop. Stop time is specified by the user following the Unix cron syntax format."
  default     = "0 19 * * MON-FRI"
}

variable "cluster_asg_1_scheduled_action_name_start" {
  description = "ASG Schedule action to start"
}

variable "cluster_asg_1_scheduled_action_name_stop" {
  description = "ASG Schedule action to stop"
}

variable "cluster_asg_1_service_name" {
  description = "Creates a unique name beginning with the specified prefix"
}

variable "cluster_asg_1_wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior or 10m."
  default     = "0"
}

variable "cluster_asg_2_cpu_scaledown_alarm" {
  description = "GREEN AWG scaledown alarm name"
}

variable "cluster_asg_2_cpu_scaledown_policy" {
  description = "GREEN AWG scaledown policy"
}

variable "cluster_asg_2_cpu_scaleup_alarm" {
  description = "GREEN AWG scaleup alarm name"
}

variable "cluster_asg_2_cpu_scaleup_policy" {
  description = "GREEN AWG scaleup policy"
}

variable "cluster_asg_2_desired_capacity_start" {
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "cluster_asg_2_desired_capacity_stop" {
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "cluster_asg_2_image_id" {
  description = "Creates a unique name for launch configuration beginning with the specified prefix"
}

variable "cluster_asg_2_initial_lifecycle_hook_name" {
  description = "The name of initial lifecycle hook"
}

variable "cluster_asg_2_lc_name" {
  description = "Creates a unique name for launch configuration beginning with the specified prefix"
}

variable "cluster_asg_2_max_size_start" {
  description = "The maximum size of the auto scale group"
}

variable "cluster_asg_2_max_size_stop" {
  description = "The maximum size of the auto scale group"
}

variable "cluster_asg_2_min_size_start" {
  description = "The minimum size of the auto scale group"
}

variable "cluster_asg_2_min_size_stop" {
  description = "The minimum size of the auto scale group"
}

variable "cluster_asg_2_name" {
  description = "Creates a unique name for autoscaling group beginning with the specified prefix"
}

variable "cluster_asg_2_recurrence_start" {
  description = "The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format."
  default     = "0 07 * * MON-FRI"
}

variable "cluster_asg_2_recurrence_stop" {
  description = "The time when recurring future actions will stop. Stop time is specified by the user following the Unix cron syntax format."
  default     = "0 19 * * MON-FRI"
}

variable "cluster_asg_2_scheduled_action_name_start" {
  description = "ASG Schedule action to start"
}

variable "cluster_asg_2_scheduled_action_name_stop" {
  description = "ASG Schedule action to stop"
}

variable "cluster_asg_2_service_name" {
  description = "Creates a unique name beginning with the specified prefix"
}

variable "cluster_asg_2_wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior or 10m."
  default     = "0"
}

variable "cluster_ec2_iam_role_name" {
  description = "Cluster IAM Role Name"
}

variable "cluster_sg_description" {
  description = "Description of options security group"
  default     = "Cluster Security Group description"
}

variable "cluster_sg_name" {
  description = "Cluster Security Group Name"
}

variable "cost_code" {
  description = "DWP Cost Code"
}

variable "ec2_cmg_dm_ses_iam_policy" {}

variable "ec2_cmg_dm_yum_repo_s3_policy_name" {}

variable "jenkins_sg_id" {
  description = "Jenkins Security Group ID"
}

variable "jenkins_sg_name" {
  description = "Jenkins Security Group Name"
}

variable "jenkinsslave_sg_id" {
  description = "Jenkins Slave Security Group ID"
}

variable "jenkinsslave_sg_name" {
  description = "Jenkins Slave Security Group Name"
}

variable "key_name" {
  description = "Key Name"
}

variable "owner" {
  description = "DWP Product Owner"
}

variable "private_subnets" {
  description = "VPC Private Subnet ID"
  type = "list"
  default = []
}

variable "product" {
  description = "DWP Product"
}

variable "product_family" {
   description = "DWP Product Family"
}

variable "prometheus_sg_id" {
  description = "Prometheus Security Group ID"
}

variable "prometheus_sg_name" {
  description = "Prometheus Security Group Name"
}

variable "proxy_sg_id" {
  description = "Proxy Security Group ID"
}

variable "proxy_sg_name" {
  description = "Proxy Security Group Name"
}

variable "public_subnets" {
  description = "Public Subnet IDs"
  type = "list"
  default = []
}

variable "role" {
  description = "DWP Role"
}

variable "version_tag" {
   description = "Version of deployed application"
}

variable "vpc_id" {
   description = "VPC ID"
}