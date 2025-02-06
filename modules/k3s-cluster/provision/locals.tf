locals {
  k3s_install_args = [
    "--cluster-cidr=${var.cluster_cidr}",
    "--data-dir=${var.data_dir}",
    "--default-local-storage-path=${var.local_storage_path}",
    "--disable-network-policy",
    "--disable=traefik",
    "--disable=servicelb",
    "--flannel-backend=none",
    "--flannel-iface=${var.primary_interface}", # default interface
    "--selinux",
  ]

  kubeconfig      = "k3s.yaml"
  kubeconfig_path = "./${local.kubeconfig}"

  common_ansible_args = {
    ansible_ssh_private_key_file = local_sensitive_file.ssh_key.filename
    ansible_ssh_common_args      = "-o StrictHostKeyChecking=accept-new -o ControlPath=~/%r@%h:%p -o ProxyCommand=\"ssh -W %h:%p condenser\""
    ansible_user                 = var.vm_username
    k3s_version                  = var.k3s_version
    kubeconfig_path              = local.kubeconfig_path
    leader_ip                    = var.leader_ip
    node_token                   = local.node_token
    openiscsi_version            = var.openiscsi_version
  }

  server_ansible_args = {
    k3s_role              = "server"
    k3s_uninstall_command = "/usr/local/bin/k3s-uninstall.sh"
  }

  node_token = "${random_string.token_id.result}.${random_string.token_secret.result}"
}
