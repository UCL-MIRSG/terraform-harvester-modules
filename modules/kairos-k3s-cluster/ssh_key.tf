resource "tls_private_key" "ssh" {
  algorithm = "ED25519"
}

resource "local_sensitive_file" "ssh_key" {
  filename = "${path.module}/ssh-private-key"
  content  = tls_private_key.ssh.private_key_openssh
}
