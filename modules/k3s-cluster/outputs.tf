output "ssh_private_key" {
  value     = tls_private_key.ssh.private_key_openssh
  sensitive = true
}

output "kubeconfig" {
  value     = module.install_k3s.kubeconfig
  sensitive = true
}

output "leader_ip" {
  value = var.networks[var.primary_interface].ips[0]
}
