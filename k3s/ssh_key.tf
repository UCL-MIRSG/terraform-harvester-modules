resource "local_sensitive_file" "ssh_key" {
  filename = "${path.module}/ansible/ssh-private-key"
  content  = var.ssh_private_key
}
