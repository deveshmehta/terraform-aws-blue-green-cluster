variable "internal_elb_subnet_ids" {
  description = "An list of subnet ID to attach the ELB to which are within the specified VPC"
  default     = ""
}

variable "internal_elb_route53_zone_id" {
  description = "The route 53 zone ID to use for the elb DNS entries"
  default     = ""
}

variable "internal_elb_security_groups" {
  description = "Attach security groups directly to the ALB by their ID"
  type        = "list"
  default     = []
}

variable "internal_elb_computed_ingress_with_source_security_group_id" {
  description = "List of objects describing the inbound security group rules permitted on the elbs for the cluster elbs"
  type        = "list"
  default     = []
}

variable "internal_elb_number_of_computed_ingress_with_source_security_group_id" {
  description = "The count of computed ingress security groups by ID for the cluster elbs"
  default     = 0
}

variable "internal_elb_computed_ingress_with_cidr_blocks" {
  description = "List of objects describing the ingress cidr blocks rules permitted for the loadbalancer"
  type        = "list"
  default     = []
}

variable "internal_elb_number_of_computed_ingress_with_cidr_blocks" {
  description = "The count of computed ingress cidr blocks for the cluster elbs"
  default     = 0
}

variable "internal_elb_computed_egress_with_source_security_group_id" {
  description = "List of objects describing the inbound security group rules permitted on the elbs for the cluster"
  type        = "list"
  default     = []
}

variable "internal_elb_number_of_computed_egress_with_source_security_group_id" {
  description = "The count of computed egress security groups by ID for the cluster elbs"
  default     = 0
}

variable "internal_elb_computed_egress_with_cidr_blocks" {
  description = "List of objects describing the egress cidr blocks rules permitted for the cluster elbs"
  type        = "list"
  default     = []
}

variable "internal_elb_number_of_computed_egress_with_cidr_blocks" {
  description = "The count of computed egress cidr blocks for the cluster elbs"
  default     = 0
}

variable "blue_certificate_arn" {
  description = "The SSL certitificate to attach to the ALB listencers for the blue cluster"
  default     = ""
}

variable "green_certificate_arn" {
  description = "The SSL certitificate to attach to the ALB listencers for the blue cluster"
  default     = ""
}

variable "internal_elb_idle_timeout" {
  description = "How long to keep idle connections alive on the internal ELB"
  default = 60
}

variable "internal_elb_enabled" {
  description = "Whether to provision an ALB or not"
  default     = "0"
}

variable "internal_elb_sg_route53_enabled" {
  description = "Whether to provision an ALB or not"
  default     = "false"
}