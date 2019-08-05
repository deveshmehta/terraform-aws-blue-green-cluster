variable "instance_subnet_ids" {
  description = "An list of subnet IDs which are within the specified VPC"
  type        = "list"
  default     = []
}

variable "instance_route53_zone_id" {
  description = "The route 53 zone ID to use for the instance DNS entries"
}

variable "instance_security_groups" {
  description = "Attach security groups directly to the instances by their ID"
  type        = "list"
  default     = []
}

variable "instance_computed_ingress_with_source_security_group_id" {
  description = "List of objects describing the inbound security group rules permitted on the instances for the cluster instances"
  type        = "list"
  default     = []
}

variable "instance_number_of_computed_ingress_with_source_security_group_id" {
  description = "The count of computed ingress security groups by ID for the cluster instances"
  default     = 0
}

variable "instance_computed_ingress_with_cidr_blocks" {
  description = "List of objects describing the ingress cidr blocks rules permitted for the loadbalancer"
  type        = "list"
  default     = []
}

variable "instance_number_of_computed_ingress_with_cidr_blocks" {
  description = "The count of computed ingress cidr blocks for the cluster instances"
  default     = 0
}

variable "instance_computed_egress_with_source_security_group_id" {
  description = "List of objects describing the inbound security group rules permitted on the instances for the cluster"
  type        = "list"
  default     = []
}

variable "instance_number_of_computed_egress_with_source_security_group_id" {
  description = "The count of computed egress security groups by ID for the cluster instances"
  default     = 0
}

variable "instance_computed_egress_with_cidr_blocks" {
  description = "List of objects describing the egress cidr blocks rules permitted for the cluster instances"
  type        = "list"
  default     = []
}

variable "instance_number_of_computed_egress_with_cidr_blocks" {
  description = "The count of computed egress cidr blocks for the cluster instances"
  default     = 0
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = " "
}
