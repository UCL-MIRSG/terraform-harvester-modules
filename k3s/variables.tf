variable "calico_version" {}

variable "cluster_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "cluster_vip" {}

variable "data_dir" {}

variable "followers" {}

variable "k3s_version" {}

variable "leader_ip" {}

variable "leader_name" {}

variable "local_storage_path" {}

variable "metallb_version" {}

variable "openiscsi_version" {}

variable "primary_interface" {}

variable "ssh_private_key" {}

variable "vm_username" {}

variable "workers" {}
