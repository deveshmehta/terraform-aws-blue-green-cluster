variable "nlb_subnet_ids" {
  description = "An list of subnet ID to attach the ELB to which are within the specified VPC"
  default = ""
}

variable "nlb_route53_zone_id" {
  description = "The route 53 zone ID to use for the NLB DNS entries"
  default = ""
}

variable "nlb_is_internal" {
  description = "Whether the NLB should be configured with a private IP only, or both private and public IPs"
  default = true
}
