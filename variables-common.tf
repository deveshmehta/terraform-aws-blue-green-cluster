variable "cluster_name" {
  description = "What to name the blue/green cluster and all of its associated resources"
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