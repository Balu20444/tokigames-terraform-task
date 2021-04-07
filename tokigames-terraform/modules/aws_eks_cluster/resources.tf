locals {
  cluster_iam_role_arn = var.cluster_iam_role_arn 
}
resource "aws_eks_cluster" "cluster" {
  name                            = var.cluster_name
  enabled_cluster_log_types       = var.cluster_enabled_log_types
  role_arn                        = local.cluster_iam_role_arn
  version                         = var.cluster_version
  tags                            = var.tags

  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? [var.vpc_config] : []
    content {
      security_group_ids            = lookup(vpc_config.value, "security_group_ids")
      subnet_ids                    = lookup(vpc_config.value, "subnet_ids")
      endpoint_private_access       = lookup(vpc_config.value, "endpoint_private_access")
      endpoint_public_access        = lookup(vpc_config.value, "endpoint_public_access")
      public_access_cidrs           = lookup(vpc_config.value, "public_access_cidrs")
    }
  }

  dynamic encryption_config {
    for_each = toset(var.cluster_encryption_config)

    content {
      provider {
        key_arn = encryption_config.value["provider_key_arn"]
      }
      resources = encryption_config.value["resources"]
    }
  }

  dynamic "kubernetes_network_config" {
    for_each = var.kubernetes_network_config != null ? [var.kubernetes_network_config] : []
    content {
      service_ipv4_cidr             = lookup(kubernetes_network_config.value, "service_ipv4_cidr")
    }
  }
    timeouts {
    create = lookup(var.timeouts, "create", "30m")
    update = lookup(var.timeouts, "update", "60m")
    delete = lookup(var.timeouts, "delete", "15m")
  }

  /*
  depends_on = [
    aws_security_group_rule.cluster_egress_internet,
    aws_security_group_rule.cluster_https_worker_ingress,
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceControllerPolicy,
    aws_cloudwatch_log_group.cluster
  ]
 
  */
}
