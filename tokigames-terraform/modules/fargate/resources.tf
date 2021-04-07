resource "aws_eks_fargate_profile" "fargate" {
  cluster_name           = var.cluster_name
  fargate_profile_name   = var.fargate_profile_name
  pod_execution_role_arn = var.pod_execution_role_arn
  subnet_ids             = var.subnets
  tags                   = var.tags

dynamic "selector" {
  for_each = var.selector != null ? [var.selector] : []
  content {
    namespace = lookup(selector.value, "namespace")
    labels = lookup(selector.value, "labels") 
  }
}
  timeouts {
    create = lookup(var.timeouts, "create", "10m")
    delete = lookup(var.timeouts, "delete", "10m")
  }
}