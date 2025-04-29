output "ssh_private_key" {
  value     = tls_private_key.ssh.private_key_openssh
  sensitive = true
}

output "kubeconfig" {
  value     = data.local_file.kubeconfig.content
  sensitive = true
}

output "leader_ip" {
  value = module.k3s_server_vm[0].ip
}

output "ips" {
  value = module.k3s_server_vm.*.ip
}
