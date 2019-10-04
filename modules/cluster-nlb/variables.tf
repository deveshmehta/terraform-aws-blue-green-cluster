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
  description = "VPC to start the NLB in"
}

variable "subnets" {
  description = "Subnets to make the NLB available within"
}

variable "http_tcp_listeners" {
  description = "Definition of HTTP/TCP listeners"
  default     = []
}

variable "http_tcp_listeners_count" {
  description = "Number of HTTP/TCP listeners"
  default     = 0
}

variable "https_listeners_count" {
  description = "Number of HTTPS listeners"
  default     = 0
}

variable "https_listeners" {
  description = "Definition of HTTPS listeners"
  default     = []
}

variable "target_groups_count" {
  description = "Number of HTTPS listeners"
  default     = 0
}

variable "target_groups" {
  description = "Definition of target groups"
  default     = []
}

variable "load_balancer_is_internal" {
  description = "Whether the load balancer should be resolvable on the public subnet"
  default     = true
}

variable "log_bucket_name" {
  description = "S3 Log bucket to use for NLB logs"
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
  description = "Whether to provision an NLB or not"
  default     = false
}

variable "idle_timeout" {
  description = "How long to keep idle connections alive"
  default = 60
}
