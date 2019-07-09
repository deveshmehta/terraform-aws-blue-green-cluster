data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

data "aws_caller_identity" "current" {}

data "aws_elb_service_account" "main" {}

data "aws_iam_policy_document" "cluster_alb_log_bucket_policy" {
  statement {
    sid     = "AllowToPutLoadBalancerLogsToS3Bucket"
    actions = ["s3:PutObject"]

    resources = [
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-blue-internal-alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-green-internal-alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-blue-internal-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-green-internal-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-blue-external-alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-green-external-alb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-blue-external-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-green-external-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_elb_service_account.main.arn}"]
    }
  }

  statement {
    sid    = "AWSLogDeliveryWrite"
    actions = ["s3:PutObject"]

    resources = [
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-blue-internal-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-green-internal-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-blue-external-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.cluster_name}-logs/${var.cluster_name}-grene-external-nlb-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
    ]

    principals {
      type = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }

  statement {
    sid = "AWSLogDeliveryAclCheck"
    actions = ["s3:GetBucketAcl"]

    resources = [
      "arn:aws:s3:::${var.cluster_name}-logs"
    ]

    principals {
      type = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }
}

data "aws_security_group" "cloudwatch_vpc_endpoint_sg" {
  name = "${data.aws_vpc.vpc.tags["Name"]}-cloudwatch-logs-endpoint-sg"
}

# data "aws_security_group" "squid_proxy_sg" {
#   filter {
#     name = "tag:Name"
#     values = ["*-squid-proxy-sg"]
#   }

#   filter {
#     name = "tag:Workspace"
#     values = ["${data.aws_vpc.vpc.tags["Name"]}"]
#   }
# }