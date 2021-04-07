
variable "region" {
  description = "aws region"
  type = string
}
variable "vault_addr" {
  description = "vault address"
  type = string
}
variable "vault_token" {
  description = "vault token"
  type = string
}
variable "lease_seconds" {
  description = "The default TTL for credentials issued by this backend."
  type = string
}
variable "backend" {
  description = "The path the AWS secret backend is mounted at, with no leading or trailing /s."
  type = string
}
variable "role" {
  description = "The name to identify this role within the backend. Must be unique within the backend."
  type = string

}
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
}
variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
}
variable "tags" {
  description = "A map of tags to add to all resources. Tags added to launch coniguration or templates override these values for ASG Tags only."
  type        = map(any)
  default     = {}
}

variable "cluster_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster. See examples/secrets_encryption/main.tf for example format"
  type = list(object({
    provider_key_arn = string
    resources        = list(string)
  }))
  default = []
}

variable "cluster_enabled_log_types" {
  default     = []
  description = "A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
}

variable "cluster_iam_role_arn" {
  description = "Controls if EKS resources should be created (it affects almost all resources)"
  type        = string
  default     = null
}
variable "vpc_config" {
  type = object({
    security_group_ids        = list(string)       # (Optional) List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane.
    subnet_ids                = list(string)       # (Required) List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane.
    endpoint_private_access   = bool               # (Optional) Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false.
    endpoint_public_access    = bool               # (Optional) Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true
    public_access_cidrs       = list(string)       # (Optional) List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. Terraform will only perform drift detection of its value when present in a configuration.
  })
  description = "(Required) Nested argument for the VPC associated with your cluster. Amazon EKS VPC resources have specific requirements to work properly with Kubernetes. For more information, see Cluster VPC Considerations and Cluster Security Group Considerations in the Amazon EKS User Guide."
  default     = null
}
variable timeouts {
  description = "aws_eks_cluster provides the following Timeouts configuration options:"
  type = object({
    create = string # (Default 30 minutes) How long to wait for the EKS Cluster to be created.
    update = string # (Default 60 minutes) How long to wait for the EKS Cluster to be updated. Note that the update timeout is used separately for both version and vpc_config update timeouts.
    delete = string #(Default 15 minutes) How long to wait for the EKS Cluster to be deleted.
  })
}

variable "kubernetes_network_config" {
  type = object({
    service_ipv4_cidr        = string # ((Optional) The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks. We recommend that you specify a block that does not overlap with resources in other networks that are peered or connected to your VPC. You can only specify a custom CIDR block when you create a cluster, changing this value will force a new cluster to be created. The block must meet the following requirements: Within one of the following private IP address blocks: 10.0.0.0/8, 172.16.0.0.0/12, or 192.168.0.0/16. Doesn't overlap with any CIDR block assigned to the VPC that you selected for VPC. Between /24 and /12.
  })
  description = "(Optional) Configuration block with kubernetes network configuration for the cluster. Detailed below. If removed, Terraform will only perform drift detection if a configuration value is provided."
  default     = null
}
