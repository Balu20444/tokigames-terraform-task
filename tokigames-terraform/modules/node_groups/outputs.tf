output "nodegroup_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group."
  value       = aws_eks_node_group.workers.arn
}

output "nodegroup_id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon (:)."
  value       = aws_eks_node_group.workers.id
}

output "nodegroup_status" {
  description = "Status of the EKS Node Group."
  value       = aws_eks_node_group.workers.status
}
