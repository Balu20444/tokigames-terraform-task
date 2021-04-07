resource "aws_eks_node_group" "workers" {
  cluster_name              = var.cluster_name
  node_group_name           = var.node_group_name
  node_role_arn             = var.node_role_arn
  subnet_ids                = var.subnet_ids
  ami_type                  = var.ami_type
  disk_size                 = var.disk_size
  force_update_version      = var.force_update_version
  instance_types            = var.instance_types
  labels                    = var.labels
  release_version           = var.release_version
  tags                      = var.tags
  version                   = var.kubernetes_version
  capacity_type             = var.capacity_type

   dynamic "launch_template" {
    for_each = (var.launch_template != null ? [var.launch_template] : [])
    content {
//      id                    = lookup(launch_template.value, "id")
      version               = lookup(launch_template.value, "version")
      name                  = lookup(launch_template.value, "name")
    }
  }
   dynamic "remote_access" {
    for_each = (var.remote_access != null ? [var.remote_access] : [])
    content {
      ec2_ssh_key                         = lookup(remote_access.value, "ec2_ssh_key")
      source_security_group_ids           = lookup(remote_access.value, "source_security_group_ids")
    }
  }
   dynamic "scaling_config" {
    for_each = (var.scaling_config != null ? [var.scaling_config] : [])
    content {
      desired_size          = lookup(scaling_config.value, "desired_size")
      max_size              = lookup(scaling_config.value, "max_size")
      min_size              = lookup(scaling_config.value, "min_size")
    }
  }
  lifecycle {
    ignore_changes          = [scaling_config.0.desired_size]
  }
}
