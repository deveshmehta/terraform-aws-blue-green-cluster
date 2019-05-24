variable "green_image_id" {
  description = "The AMI ID to use for the green cluster"
}

variable "green_application_ports" {
  description = "The ports the ALB should be able to connect to the green cluster on"
  type        = "list"
  default     = []
}

variable "green_version_tag" {
  description = "The version of the green product release"
}

variable "green_instance_type" {
  description = "The instance type to use for the green cluster"
  default     = "t2.small"
}

variable "green_weight" {
  description = "Weight of the DNS record for the green cluster"
}

variable "green_max_size" {
  description = "The number of instances to put into the green cluster"
  default     = 1
}

variable "green_min_size" {
  description = "The number of instances to put into the green cluster"
  default     = 1
}

variable "green_desired_capacity" {
  description = "The number of instances to put into the green cluster"
  default     = 1
}

variable "green_wait_for_capacity_timeout" {
  description = "How long to wait before timing out introducing the new green ASG instances"
  default     = 0
}

variable "green_recurrence_start" {
  description = "When to start the green instances"
  default = "false"
}

variable "green_recurrence_stop" {
  description = "When to stop the green instances"
  default = "false"
}

variable "green_min_size_start" {
  description = "How many instances to start when the ASG start hook is triggered"
}

variable "green_max_size_start" {
  description = "How many instances to start when the ASG start hook is triggered"
}

variable "green_desired_capacity_start" {
  description = "How many instances to start when the ASG start hook is triggered"
}

variable "green_min_size_stop" {
  description = "How many instances to stop when the ASG stop hook is triggered"
}

variable "green_max_size_stop" {
  description = "How many instances to stop when the ASG stop hook is triggered"
}

variable "green_desired_capacity_stop" {
  description = "How many instances to stop when the ASG stop hook is triggered"
}

variable "green_route53_aliases_name" {
  description = "List of ALB Route53 aliases"
  type        = "list"
  default     = []
}

variable "green_target_groups_count" {
  description = "The number of target groups to attach to the green ALB"
  default     = 0
}

variable "green_target_groups" {
  description = "The target groups to attach to the green ALB"
  type        = "list"
  default     = []
}

variable "green_alb_https_listeners_count" {
  description = "The number of HTTPS listeners to attach the green ALB"
  default     = 0
}

variable "green_alb_https_listeners" {
  description = "The listeners to attach to the green ALB"
  type        = "list"
  default     = []
}

variable "green_alb_http_tcp_listeners_count" {
  description = "The number of HTTP/TCP listeners to attach the green ALB"
  default     = 0
}

variable "green_alb_http_tcp_listeners" {
  description = "The HTTP/TCP listeners to attach to the green ALB"
  type        = "list"
  default     = []
}

variable "green_internal_alb_target_groups_count" {
  description = "The number of target groups to attach to the green ALB"
  default     = 0
}

variable "green_internal_alb_target_groups" {
  description = "The target groups to attach to the green ALB"
  type        = "list"
  default     = []
}

variable "green_external_alb_target_groups_count" {
  description = "The number of target groups to attach to the green ALB"
  default     = 0
}

variable "green_external_alb_target_groups" {
  description = "The target groups to attach to the green ALB"
  type        = "list"
  default     = []
}

variable "green_nlb_https_listeners_count" {
  description = "The number of HTTPS listeners to attach the green NLB"
  default     = 0
}

variable "green_nlb_https_listeners" {
  description = "The listeners to attach to the green NLB"
  type        = "list"
  default     = []
}

variable "green_nlb_http_tcp_listeners_count" {
  description = "The number of HTTP/TCP listeners to attach the green NLB"
  default     = 0
}

variable "green_nlb_http_tcp_listeners" {
  description = "The HTTP/TCP listeners to attach to the green NLB"
  type        = "list"
  default     = []
}

variable "green_internal_nlb_target_groups_count" {
  description = "The number of target groups to attach to the green NLB"
  default     = 0
}

variable "green_internal_nlb_target_groups" {
  description = "The target groups to attach to the green NLB"
  type        = "list"
  default     = []
}

variable "green_external_nlb_target_groups_count" {
  description = "The number of target groups to attach to the green NLB"
  default     = 0
}

variable "green_external_nlb_target_groups" {
  description = "The target groups to attach to the green NLB"
  type        = "list"
  default     = []
}
