variable "internal_nlb_subnet_ids" {
  description = "An list of subnet ID to attach the ELB to which are within the specified VPC"
  default = ""
}

variable "internal_nlb_route53_zone_id" {
  description = "The route 53 zone ID to use for the NLB DNS entries"
  default = ""
}
