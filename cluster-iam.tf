data "aws_iam_policy" "ssm_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cloudwatch_logs" {
  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:aws:logs:${var.cluster_name}-logs:*",
    ]
  }
}

data "aws_iam_policy_document" "cloudwatch_metrics" {
  statement {
    sid = "1"

    effect = "Allow"

    actions = [
      "cloudwatch:PutMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "ec2:DescribeTags".
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role" "instance" {
  name                  = "${var.cluster_name}-iam-role"
  description           = "${var.cluster_name} IAM Role"
  path                  = "/"
  force_detach_policies = false
  assume_role_policy    = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_policy" "cloudwatch_logs" {
  name   = "${var.cluster_name}-logs"
  path   = "/"
  policy = "${data.aws_iam_policy_document.cloudwatch_logs.json}"
}

resource "aws_iam_policy" "cloudwatch_metrics" {
  name   = "${var.cluster_name}-metrics"
  path   = "/"
  policy = "${data.aws_iam_policy_document.cloudwatch_metrics.json}"
}


resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  role       = "${aws_iam_role.instance.name}"
  policy_arn = "${aws_iam_policy.cloudwatch_logs.arn}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_metrics" {
  role       = "${aws_iam_role.instance.name}"
  policy_arn = "${aws_iam_policy.cloudwatch_metrics.arn}"
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = "${aws_iam_role.instance.name}"
  policy_arn = "${data.aws_iam_policy.ssm_policy.arn}"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name_prefix = "${var.cluster_name}-"
  path        = "/"
  role        = "${aws_iam_role.instance.name}"

  lifecycle {
    create_before_destroy = true
  }
}
