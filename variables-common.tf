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

variable "product" {
  description = "Product"
}

variable "cost_code" {
  description = "The code for the  costing"
}

variable "product_family" {
  description = "The product family of the project, e.g.  FA"
}

variable "owner" {
  description = "Product owner email address"
}
