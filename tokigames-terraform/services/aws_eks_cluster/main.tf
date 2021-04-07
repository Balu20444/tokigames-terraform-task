provider "vault" {
        address = var.vault_addr
        token = var.vault_token
        max_lease_ttl_seconds = var.lease_seconds
}

data "vault_aws_access_credentials" "creds" {
  backend = var.backend
  role    = var.role
}
provider "aws" {
	region = var.region
    access_key = data.vault_aws_access_credentials.creds.access_key
	secret_key = data.vault_aws_access_credentials.creds.secret_key
}

module "aws_eks_cluster" {
  source                        = "../../modules/aws_eks_cluster"
  cluster_name                  = var.cluster_name
  cluster_version               = var.cluster_version
  cluster_iam_role_arn          = var.cluster_iam_role_arn
  vpc_config                    = var.vpc_config
  timeouts                      = var.timeouts
  kubernetes_network_config     = var.kubernetes_network_config
}