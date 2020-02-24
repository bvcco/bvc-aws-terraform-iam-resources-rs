terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 2.1"
  region  = "us-west-2"
}

data "aws_iam_policy_document" "vpc_peer_cross_account_role" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:AcceptVpcPeeringConnection"]
    resources = ["*"]
  }
}

module "vpc_peer_cross_account_role" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.12.0"

  name        = "VPCPeerCrossAccountRole"
  aws_account = ["794790922771"]

  inline_policy       = [data.aws_iam_policy_document.vpc_peer_cross_account_role.json]
  inline_policy_count = 1
}
