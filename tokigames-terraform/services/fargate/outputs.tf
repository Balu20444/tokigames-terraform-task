output "fargate_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Fargate Profile."
  value       = module.fargate.fargate_arn
}

output "fargate_id" {
  description = "EKS Cluster name and EKS Fargate Profile name separated by a colon (:)."
  value       = module.fargate.fargate_id
}

output "fargate_status" {
  description = "Status of the EKS Fargate Profile."
  value       = module.fargate.fargate_status
}