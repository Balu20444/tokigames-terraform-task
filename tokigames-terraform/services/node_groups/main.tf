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

module "node_groups" {
  source          = "../../modules/node_groups"
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  ami_type        = var.ami_type
  disk_size       = var.disk_size
  instance_types  = var.instance_types
  scaling_config  = var.scaling_config
  remote_access   = var.remote_access
  launch_template = var.launch_template
  subnet_ids      = var.subnet_ids

}
