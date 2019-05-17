##################################################################################
# S3 for Options App ALB logs
##################################################################################
resource "aws_s3_bucket" "log_bucket" {
  bucket        = "${var.cluster_name}-logs"
  policy        = "${data.aws_iam_policy_document.cluster_alb_log_bucket_policy.json}"
  force_destroy = true

  tags = "${map(
    "Environment", "${terraform.workspace}",
    "Workspace", "${terraform.workspace}",
    "Product", "${var.product}",
    "Product Family", "${var.product_family}",
    "Costcode", "${var.cost_code}",
    "Owner", "${var.owner}",
    "Role" , "ALB Logs",
    "Version" , "${var.version_tag}",
    "Persistence", "true",
    "Terraform", "True",
    "load_balancer_is_internal", "True"
  )}"

  lifecycle_rule {
    id      = "log-expiration"
    enabled = "true"

    expiration {
      days = "7"
    }
  }
}