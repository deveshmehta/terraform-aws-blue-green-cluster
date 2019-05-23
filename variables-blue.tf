variable "blue_image_id" {
  description = "The AMI ID to use for the blue cluster"
}

variable "blue_application_ports" {
  description = "The ports the ALB should be able to connect to the blue cluster on"
  type        = "list"
  default     = []
}

variable "blue_version_tag" {
  description = "The version of the blue product release"
}

variable "blue_instance_type" {
  description = "The instance type to use for the blue cluster"
  default     = "t2.small"
}

variable "blue_weight" {
  description = "Weight of the DNS record for the blue cluster"
}

variable "blue_max_size" {
  description = "The number of instances to put into the blue cluster"
  default     = 1
}

variable "blue_min_size" {
  description = "The number of instances to put into the blue cluster"
  default     = 1
}

variable "blue_desired_capacity" {
  description = "The number of instances to put into the blue cluster"
  default     = 1
}

variable "blue_wait_for_capacity_timeout" {
  description = "How long to wait before timing out introducing the new green ASG instances"
  default     = 0
}

variable "blue_recurrence_start" {
  description = "When to start the instances"
}

variable "blue_recurrence_stop" {
  description = "When to stop the instances"
}

variable "blue_min_size_start" {
  description = "How many instances to start when the ASG start hook is triggered"
}

variable "blue_max_size_start" {
  description = "How many instances to start when the ASG start hook is triggered"
}

variable "blue_desired_capacity_start" {
  description = "How many instances to start when the ASG start hook is triggered"
}

variable "blue_min_size_stop" {
  description = "How many instances to stop when the ASG stop hook is triggered"
}

variable "blue_max_size_stop" {
  description = "How many instances to stop when the ASG stop hook is triggered"
}

variable "blue_desired_capacity_stop" {
  description = "How many instances to stop when the ASG stop hook is triggered"
}

variable "blue_route53_aliases_name" {
  description = "List of ALB Route53 aliases"
  type        = "list"
  default     = []
}

variable "blue_alb_https_listeners_count" {
  description = "The number of HTTPS listeners to attach the blue ALB"
  default     = 0
}

variable "blue_alb_https_listeners" {
  description = "The listeners to attach to the blue ALB"
  type        = "list"
  default     = []
}

variable "blue_alb_http_tcp_listeners_count" {
  description = "The number of HTTP/TCP listeners to attach the blue ALB"
  default     = 0
}

variable "blue_alb_http_tcp_listeners" {
  description = "The HTTP/TCP listeners to attach to the blue ALB"
  type        = "list"
  default     = []
}

variable "blue_internal_alb_target_groups_count" {
  description = "The number of target groups to attach to the blue ALB"
  default     = 0
}

variable "blue_internal_alb_target_groups" {
  description = "The target groups to attach to the blue ALB"
  type        = "list"
  default     = []
}

variable "blue_external_alb_target_groups_count" {
  description = "The number of target groups to attach to the blue ALB"
  default     = 0
}

variable "blue_external_alb_target_groups" {
  description = "The target groups to attach to the blue ALB"
  type        = "list"
  default     = []
}

variable "blue_nlb_https_listeners_count" {
  description = "The number of HTTPS listeners to attach the blue NLB"
  default     = 0
}

variable "blue_nlb_https_listeners" {
  description = "The listeners to attach to the blue NLB"
  type        = "list"
  default     = []
}

variable "blue_nlb_http_tcp_listeners_count" {
  description = "The number of HTTP/TCP listeners to attach the blue NLB"
  default     = 0
}

variable "blue_nlb_http_tcp_listeners" {
  description = "The HTTP/TCP listeners to attach to the blue NLB"
  type        = "list"
  default     = []
}

variable "blue_internal_nlb_target_groups_count" {
  description = "The number of target groups to attach to the blue ALB"
  default     = 0
}

variable "blue_internal_nlb_target_groups" {
  description = "The target groups to attach to the blue ALB"
  type        = "list"
  default     = []
}

variable "blue_external_nlb_target_groups_count" {
  description = "The number of target groups to attach to the blue ALB"
  default     = 0
}

variable "blue_external_nlb_target_groups" {
  description = "The target groups to attach to the blue ALB"
  type        = "list"
  default     = []
}
