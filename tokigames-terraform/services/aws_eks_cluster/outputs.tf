output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = module.aws_eks_cluster.cluster_arn
}

output "cluster_id" {
  description = "The name of the cluster."
  value       = module.aws_eks_cluster.cluster_id
}

output "cluster_status" {
  description = "The status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED."
  value       = module.aws_eks_cluster.cluster_status
}
output "cluster_version" {
  description = "The Kubernetes server version for the cluster."
  value       = module.aws_eks_cluster.cluster_version
}
