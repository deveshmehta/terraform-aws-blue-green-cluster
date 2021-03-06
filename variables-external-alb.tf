variable "external_alb_subnet_ids" {
  description = "An list of subnet ID to attach the ELB to which are within the specified VPC"
  default     = ""
}

variable "external_alb_route53_zone_id" {
  description = "The route 53 zone ID to use for the ALB DNS entries"
  default     = ""
}

variable "external_alb_security_groups" {
  description = "Attach security groups directly to the ALB by their ID"
  type        = "list"
  default     = []
}

variable "external_alb_computed_ingress_with_source_security_group_id" {
  description = "List of objects describing the inbound security group rules permitted on the albs for the cluster albs"
  type        = "list"
  default     = []
}

variable "external_alb_number_of_computed_ingress_with_source_security_group_id" {
  description = "The count of computed ingress security groups by ID for the cluster albs"
  default     = 0
}

variable "external_alb_computed_ingress_with_cidr_blocks" {
  description = "List of objects describing the ingress cidr blocks rules permitted for the loadbalancer"
  type        = "list"
  default     = []
}

variable "external_alb_number_of_computed_ingress_with_cidr_blocks" {
  description = "The count of computed ingress cidr blocks for the cluster albs"
  default     = 0
}

variable "external_alb_computed_egress_with_source_security_group_id" {
  description = "List of objects describing the inbound security group rules permitted on the albs for the cluster"
  type        = "list"
  default     = []
}

variable "external_alb_number_of_computed_egress_with_source_security_group_id" {
  description = "The count of computed egress security groups by ID for the cluster albs"
  default     = 0
}

variable "external_alb_computed_egress_with_cidr_blocks" {
  description = "List of objects describing the egress cidr blocks rules permitted for the cluster albs"
  type        = "list"
  default     = []
}

variable "external_alb_number_of_computed_egress_with_cidr_blocks" {
  description = "The count of computed egress cidr blocks for the cluster albs"
  default     = 0
}

variable "external_alb_idle_timeout" {
  description = "How long to keep idle connections alive on the external ALB"
  default = 60
}
