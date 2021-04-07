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

module "fargate" {
  source                            = "../../modules/fargate"
  cluster_name                      = var.cluster_name
  fargate_profile_name              = var.fargate_profile_name
  subnets                           = var.subnets
  pod_execution_role_arn            = var.pod_execution_role_arn
  selector                          = var.selector
  timeouts                          = var.timeouts
}