variable "cluster_name" {
  description = " (Required) Name of the cluster."
  type        = string
}
variable "cluster_version" {
  description = " (Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
  type        = string
}
variable "tags" {
  description = " (Optional) Key-value map of resource tags."
  type        = map(any)
  default     = {}
}

variable "cluster_encryption_config" {
  description = "(Optional) Configuration block with encryption configuration for the cluster. Only available on Kubernetes 1.13 and above clusters created after March 6, 2020. Detailed below."
  type = list(object({
    provider_key_arn = string       # (Required) Amazon Resource Name (ARN) of the Key Management Service (KMS) customer master key (CMK). The CMK must be symmetric, created in the same region as the cluster, and if the CMK was created in a different account, the user must have access to the CMK. 
    resources        = list(string) # (Required) List of strings with resources to be encrypted. Valid values: secrets
  }))
  default = []
}

variable "cluster_enabled_log_types" {
  description = "(Optional) A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging"
  type        = list(string)
  default     = []
}

variable "cluster_iam_role_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf. Ensure the resource configuration includes explicit dependencies on the IAM Role permissions by adding depends_on if using the aws_iam_role_policy resource or aws_iam_role_policy_attachment resource, otherwise EKS cannot delete EKS managed EC2 infrastructure such as Security Groups on EKS Cluster deletion."
  type        = string
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
