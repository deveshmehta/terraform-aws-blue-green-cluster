##################################################################################
# Options app IAM Role
##################################################################################
module "cluster_iam" {
  source = "git::https://gitlab.nonprod.dwpcloud.uk/cmg-next-generation-services/DevOps/cmg-terraform/modules/cmg-terraform-aws-ec2-iam-role.git"

  #source = "Smartbrood/ec2-iam-role/aws"
  name = "cmg-${var.cluster_name}-iam-role"

  policy_arn = ["${var.iam_policies}"]
}
