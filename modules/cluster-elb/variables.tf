variable "vpc_id" {
  description = "The ID of the VPC in which the nodes will be deployed."
}

variable "route53_domain_name" {
  description = "The base DNS name for the account"
}

variable "cluster_name" {
  description = "The name of the cluster. This variable is used to namespace all resources created by this module."
}

variable "subnet_ids" {
  description = "The subnet IDs into which the ELB should be deployed. We recommend one subnet ID per node in the cluster_size variable. At least one of var.subnet_ids or var.availability_zones must be non-empty."
  type        = "list"
  default     = []
}

variable "ssl_certificate" {
  description = "AWS SSL Certificate to attach to the ELB"
}

variable "instance_port" {
  description = "The port on the backend servers that is open to the ELB, e.g. what the microservice API is listening on"
  default     = 8080
}

variable "computed_ingress_with_source_security_group_id" {
  description = "List of objects describing the inbound security group rules permitted on the loadbalancer"
  type        = "list"
  default     = []
}

variable "elb_enabled" {
  description = "Whether to provision an ALB or not"
  default     = "false"
}

variable "elb_sg_route53_enabled" {
  description = "Whether to provision an ALB or not"
  default     = "false"
}

variable "number_of_computed_ingress_with_source_security_group_id" {
  description = "The count of computed ingress security groups by ID"
  default     = 0
}

variable "computed_ingress_with_cidr_blocks" {
  description = "List of objects describing the ingress cidr blocks rules permitted"
  type        = "list"
  default     = []
}

variable "number_of_computed_ingress_with_cidr_blocks" {
  description = "The count of computed ingress cidr blocks"
  default     = 0
}

variable "computed_egress_with_source_security_group_id" {
  description = "List of objects describing the egress security group rules permitted on the Load balancers"
  type        = "list"
  default     = []
}

variable "number_of_computed_egress_with_source_security_group_id" {
  description = "The count of computed ingress security groups by ID for the Load balancer"
  default     = 0
}

variable "computed_egress_with_cidr_blocks" {
  description = "List of objects describing the egress cidr blocks rules permitted for the loadbalancer"
  type        = "list"
  default     = []
}

variable "number_of_computed_egress_with_cidr_blocks" {
  description = "The count of computed egress cidr blocks for the loadbalancer"
  default     = 0
}

variable "application_ports" {
  description = "The ports that the application listens on.  Used to automate egress rules on the ALB"
  type        = "list"
  default     = []
}

variable "application_security_group_id" {
  description = "The securtiy group attached the application ASG instances. Used to automate egress rules on the ALB"
}

variable "tags" {
  description = "tags for the instance"
  type        = "map"
  default     = {}
}

variable "instances" {
  description = "List of the instances to attach to the ELB"
  type = "list"
  default = []
}

variable "number_of_instances" {
  description = "The number of instances to attach to the ELB"
  default = 0
}


variable "cost_code" {
  description = "The code for the CMG costing"
}

variable "product_family" {
  description = "The product family of the project, e.g. CMG FA"
}

variable "product" {
  description = "The product of the project, e.g. Proxy Server"
}

variable "role" {
  description = "Role of the service"
}

variable "owner" {
  description = "Product owner email address"
}

variable "version_tag" {
  description = "Release of the product image"
}

variable "color" {
  description = "The color to assign to the cluster naming"
}

variable "route53_aliases_name" {
  description = "Route53 aliases"
  type        = "list"
  default     = []
}

variable "route53_zone_id" {
  description = "Route53 Zone ID"
  default = ""
}

variable "idle_timeout" {
  description = "How long to keep idle connections alive"
  default = 60
}