output "fargate_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Fargate Profile."
  value       = aws_eks_fargate_profile.fargate.arn
}

output "fargate_id" {
  description = "EKS Cluster name and EKS Fargate Profile name separated by a colon (:)."
  value       = aws_eks_fargate_profile.fargate.id
}

output "fargate_status" {
  description = "Status of the EKS Fargate Profile."
  value       = aws_eks_fargate_profile.fargate.status
}
