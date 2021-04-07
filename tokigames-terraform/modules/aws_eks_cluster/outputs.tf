output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = aws_eks_cluster.cluster.arn
}

output "cluster_id" {
  description = "The name of the cluster."
  value       = aws_eks_cluster.cluster.id
}

output "cluster_status" {
  description = "The status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED."
  value       = aws_eks_cluster.cluster.status
}

output "cluster_version" {
  description = "The Kubernetes server version for the cluster."
  value       = aws_eks_cluster.cluster.version
}
