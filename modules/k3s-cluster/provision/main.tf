resource "null_resource" "galaxy" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = join(" ", [
      "ansible-galaxy",
      "install",
      "-r ${path.module}/ansible/requirements.yaml",
      "--force"
    ])
  }
}

resource "ansible_playbook" "k3s_leader" {
  depends_on              = [null_resource.galaxy]
  name                    = var.leader_name
  playbook                = "${path.module}/ansible/playbook.yaml"
  groups                  = ["k3s", "leader"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = merge(local.common_ansible_args, local.server_ansible_args, {
    ansible_host   = local.leader_ip
    cluster_vip    = var.cluster_vip
    calico_version = var.calico_version
    k3s_install_args = join(" ", concat(local.k3s_install_args, [
      "--node-ip=${local.leader_ip}",
      "--tls-san=${local.leader_ip}",
      "--advertise-address=${local.leader_ip}",
      "--cluster-init"
    ]))
    metallb_version = var.metallb_version
  })
}

resource "ansible_playbook" "k3s_follower" {
  depends_on              = [null_resource.galaxy, ansible_playbook.k3s_leader]
  for_each                = local.followers
  name                    = each.key
  playbook                = "${path.module}/ansible/playbook.yaml"
  groups                  = ["k3s"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = merge(local.common_ansible_args, local.server_ansible_args, {
    ansible_host = each.value
    k3s_install_args = join(" ", concat(local.k3s_install_args, [
      "--node-ip=${each.value}",
      "--tls-san=${each.value}",
      "--advertise-address=${each.value}"
    ]))
    k3s_url = "https://${local.leader_ip}:6443"
  })
}

resource "ansible_playbook" "k3s_worker" {
  depends_on              = [null_resource.galaxy, ansible_playbook.k3s_follower]
  for_each                = local.workers
  name                    = each.key
  playbook                = "${path.module}/ansible/playbook.yaml"
  groups                  = ["k3s"]
  ignore_playbook_failure = false
  replayable              = true
  extra_vars = merge(local.common_ansible_args, {
    ansible_host          = each.value
    k3s_role              = "agent"
    k3s_uninstall_command = "/usr/local/bin/k3s-agent-uninstall.sh"
    k3s_url               = "https://${local.leader_ip}:6443"
  })
}

data "local_file" "kubeconfig" {
  depends_on = [ansible_playbook.k3s_leader, ansible_playbook.k3s_follower, ansible_playbook.k3s_worker]
  filename   = "${path.module}/ansible/${local.kubeconfig}"
}
