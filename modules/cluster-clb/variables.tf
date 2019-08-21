variable "cluster_name" {
  description = "What to name the blue/green cluster and all of its associated resources"
}

variable "color" {
  description = "The color to assign to the cluster naming"
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

variable "tags" {
  description = "Additional tags to add to the cluster."
  type        = "list"
  default     = []
}

variable "vpc_id" {
  description = "VPC to start the CLB in"
}

variable "subnets" {
  description = "Subnets to make the CLB available within"
}

variable "clb_listeners" {
  description = "Definition of HTTP/HTTPS/TCP listeners"
  default     = []
}

variable "clb_health_check" {
  description = "A maps containing key/value pairs that define health_check. Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend_protocol, backend_port. Optional key/values are in the target_groups_defaults variable."
  type        = "list"
  default     = []
}

variable "load_balancer_is_internal" {
  description = "Whether the load balancer should be resolvable on the public subnet"
  default     = true
}

variable "log_bucket_name" {
  description = "S3 Log bucket to use for CLB logs"
}

variable "route53_aliases_name" {
  description = "Route53 aliases"
  type        = "list"
  default     = []
}

variable "route53_zone_id" {
  description = "Route53 zone ID"
}

variable "enabled" {
  description = "Whether to provision an CLB or not"
  default     = false
}

variable "security_groups" {
  description = "Security groups to attach directly to the ALB"
  type        = "list"
  default     = []
}

variable "computed_ingress_with_source_security_group_id" {
  description = "List of objects describing the inbound security group rules permitted on the Load balancers"
  type        = "list"
  default     = []
}

variable "number_of_computed_ingress_with_source_security_group_id" {
  description = "The count of computed ingress security groups by ID for the Load balancer"
  default     = 0
}

variable "computed_ingress_with_cidr_blocks" {
  description = "List of objects describing the ingress cidr blocks rules permitted for the loadbalancer"
  type        = "list"
  default     = []
}

variable "number_of_computed_ingress_with_cidr_blocks" {
  description = "The count of computed ingress cidr blocks for the loadbalancer"
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

variable "application_security_group_id" {
  description = "The securtiy group attached the application ASG instances. Used to automate egress rules on the ALB"
}

variable "application_ports" {
  description = "The ports that the application listens on.  Used to automate egress rules on the ALB"
  type        = "list"
  default     = []
}
