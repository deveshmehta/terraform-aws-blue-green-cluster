data "aws_caller_identity" "current" {}

data "aws_elb_service_account" "main" {}

data "aws_iam_policy_document" "cluster_alb_log_bucket_policy" {
  statement {
    sid     = "AllowToPutLoadBalancerLogsToS3Bucket"
    actions = ["s3:PutObject"]

    resources = [
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-blue-alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-green-alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-blue-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-green-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_elb_service_account.main.arn}"]
    }
  }
}