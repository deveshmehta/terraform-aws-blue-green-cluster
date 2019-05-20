variable "vpc_id" {
  description = "The ID of the VPC to launch the instances into"
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair."
  default     = ""
}

variable "iam_policies" {
  description = "The IAM policies to attach to the IAM role for the cluster instances"
  default = []
  type = "list"
}

variable "nlb_enabled" {
  description = "Whether to create an NLB or not"
  default = false
}

variable "alb_enabled" {
  description = "Whether to create an ALB or not"
  default = true
}



