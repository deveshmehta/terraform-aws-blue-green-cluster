variable "cluster_name" {
  description = "What to name the blue/green cluster and all of its associated resources"
}

variable "color" {
  description = "The color to assign to the cluster naming"
}

variable "image_id" {
  description = "The AMI ID to use for the cluster"
}

variable "instance_type" {
  description = "The instance type to use for the cluster"
  default     = "t2.small"
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair."
  default     = ""
}

variable "target_group_arns" {
  description = "The target groups from the load balancer to attach the new instances to"
  type        = "list"
  default     = []
}

variable "clb_load_balancer_arns" {
  description = "The target groups from the load balancer to attach the new instances to"
  type        = "list"
  default     = []
}

variable "security_groups" {
  description = "The security groups to attach to the ASG instances"
  type        = "list"
  default     = []
}

variable "load_balancers" {
  description = "The security groups to attach to the ASG instances"
  type        = "list"
  default     = []
}

variable "max_size" {
  description = "The number of instances to put into the cluster"
  default     = 1
}

variable "min_size" {
  description = "The number of instances to put into the cluster"
  default     = 1
}

variable "desired_capacity" {
  description = "The number of instances to put into the cluster"
  default     = 1
}

variable "wait_for_capacity_timeout" {
  description = "How long to wait before timing out introducing the new ASG instances"
  default     = 0
}

variable "recurrence_start" {
  description = "When to start the instances"
  default     = "false"
}

variable "recurrence_stop" {
  description = "When to stop the instances"
  default     = "false"
}

variable "min_size_start" {
  description = "How many instances to start when the ASG start hook is triggered"
  default     = 1
}

variable "max_size_start" {
  description = "How many instances to start when the ASG start hook is triggered"
  default     = 1
}

variable "desired_capacity_start" {
  description = "How many instances to start when the ASG start hook is triggered"
  default     = 1
}

variable "min_size_stop" {
  description = "How many instances to stop when the ASG stop hook is triggered"
  default     = 0
}

variable "max_size_stop" {
  description = "How many instances to stop when the ASG stop hook is triggered"
  default     = 0
}

variable "desired_capacity_stop" {
  description = "How many instances to stop when the ASG stop hook is triggered"
  default     = 0
}

variable "iam_instance_profile" {
  description = "The IAM profile to attach to new instances"
  default     = ""
}

variable "subnet_ids" {
  description = "The subnets to launch the instances into"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "Additional tags to add to the cluster."
  type        = "list"
  default     = []
}

variable "role" {
  description = "Role of the product within the account"
}

variable "version_tag" {
  description = "The version of the product"
}

variable "product" {
  description = "Product"
}

variable "cost_code" {
  description = "The code for the CMG costing"
}

variable "product_family" {
  description = "The product family of the project, e.g. CMG FA"
}

variable "owner" {
  description = "Product owner email address"
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = " "
}
