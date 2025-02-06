locals {
  ips = var.networks[var.primary_interface].ips

  leader_name = "${var.vm_prefix}-${var.cluster_name}-control-0"
  leader_ip   = local.ips[0]

  leader = {
    "${local.leader_name}" = local.leader_ip
  }

  followers = {
    for k, v in slice(local.ips, 1, var.control_nodes) :
    "${var.vm_prefix}-${var.cluster_name}-control-${k + 1}" => v
  }

  workers = {
    for k, v in slice(local.ips, var.control_nodes, length(local.ips)) :
    "${var.vm_prefix}-${var.cluster_name}-worker-${k}" => v
  }

  vms      = merge(local.leader, local.followers, local.workers)
  vm_count = length(local.vms)
  vm_names = keys(local.vms)
}
