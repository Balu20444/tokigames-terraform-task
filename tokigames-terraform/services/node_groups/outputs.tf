output "nodegroup_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group."
  value       = module.node_groups.nodegroup_arn
}

output "nodegroup_id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon (:)."
  value       = module.node_groups.nodegroup_id
}

output "nodegroup_status" {
  description = "Status of the EKS Node Group."
  value       = module.node_groups.nodegroup_status
}
