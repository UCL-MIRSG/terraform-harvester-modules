
variable "name" {
  type        = string
  description = "Name of the vm"
}

variable "appstream_repo_url" {
  type    = string
  default = ""
}

variable "additional_disks" {
  type = map(object({
    name  = string
    mount = string
    size  = string
  }))
}

variable "baseos_repo_url" {
  type    = string
  default = ""
}

variable "cpu" {
  type    = number
  default = 4
}

variable "efi_boot" {
  type = bool
}

variable "memory" {
  type    = string
  default = "32Gi"
}

variable "networks" {
  type = map(object({
    ip      = string
    cidr    = number
    gateway = string
    dns     = string
    network = string
    iface   = string
  }))

  description = "Map of harvester VM networks to add NICs for"
}

variable "namespace" {
  type        = string
  description = "Name of the namespace into which the VMs with be delployed. It must exist"
}

variable "primary_interface" {
  type        = string
  description = "The primary interface to use for the VM"
}

variable "root_disk_size" {
  type    = string
  default = "30Gi"
}

variable "run_strategy" {
  type    = string
  default = "RerunOnFailure"
}

variable "ssh_public_key" {
  type = string
}

variable "ssh_private_key" {
  type = string
}

variable "vm_image" {
  type        = string
  default     = "rhel-9.3"
  description = "OS image to use"
}

variable "vm_image_namespace" {
  type        = string
  default     = ""
  description = "OS image namespace to use"
}

variable "vm_username" {
  type = string
}
