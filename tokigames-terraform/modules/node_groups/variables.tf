variable "cluster_name" {
  description = "(Required) Name of the EKS Cluster."
  type        = string

}
variable "node_group_name" {
  description = "(Required) Name of the EKS Node Group."
  type        = string

}
variable "node_role_arn" {
  description = "(Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group."
  type        = string

}

variable "subnet_ids" {
  description = "(Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
  type        = list(string)

}
variable "ami_type" {
  description = "(Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64. Terraform will only perform drift detection if a configuration value is provided."
  type        = string
  default     = null
}
variable "disk_size" {
  description = "(Optional) Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided."
  type        = number
  default     = null
}
variable "force_update_version" {
  description = "(Optional) Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
  type        = string
  default     = null
}
variable "labels" {
  description = "(Optional) Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed."
  type        = map(any)
  default     =  null
}
variable "release_version" {
  description = "(Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version."
  type        = string
  default     =  null
}

variable "instance_types" {
  description = " (Optional) Set of instance types associated with the EKS Node Group"
  type        = list(string)
  default     = null
}

variable "scaling_config" {
  type = object({
    desired_size       = number # (Required) Desired number of worker nodes.
    max_size           = number # (Required) Maximum number of worker nodes.
    min_size           = number #(Required) Minimum number of worker nodes.
  })
  description = "(Required) Configuration block with scaling settings. Detailed below."
}

variable "launch_template" {
  type = object({
//    id                = number #  (Optional) Identifier of the EC2 Launch Template. Conflicts with name.
    name              = string # (Optional) Name of the EC2 Launch Template. Conflicts with id.
    version           = string # (Required) EC2 Launch Template version number. While the API accepts values like $Default and $Latest, the API will convert the value to the associated version number (e.g. 1) on read and Terraform will show a difference on next plan. Using the default_version or latest_version attribute of the aws_launch_template resource or data source is recommended for this argument.
  })
  description = " (Optional) Configuration block with Launch Template settings. Detailed below."
  default     = null
}
variable "remote_access" {
  type = object({
    ec2_ssh_key                         = string # (Optional) EC2 Key Pair name that provides access for SSH communication with the worker nodes in the EKS Node Group. If you specify this configuration, but do not specify source_security_group_ids when you create an EKS Node Group, port 22 on the worker nodes is opened to the Internet (0.0.0.0/0).
    source_security_group_ids           = list(string) # (Optional) Set of EC2 Security Group IDs to allow SSH access (port 22) from on the worker nodes. If you specify ec2_ssh_key, but do not specify this configuration when you create an EKS Node Group, port 22 on the worker nodes is opened to the Internet (0.0.0.0/0).
  })
  description = "(Optional) Configuration block with remote access settings. Detailed below."
  default     = null
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(any)
  default     =  null
}

variable "kubernetes_version" {
  description = "(Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided."
  type        = number
  default     =  null
}
variable "capacity_type" {
  description = " (Optional) Type of capacity associated with the EKS Node Group. Defaults to ON_DEMAND. Valid values: ON_DEMAND, SPOT."
  type        = string
  default     =  null
}