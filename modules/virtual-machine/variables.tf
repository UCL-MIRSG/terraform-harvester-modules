variable "name" {
  type        = string
  description = "Name of the vm"
}

variable "additional_disks" {
  type = map(object({
    name  = string
    mount = string
    size  = string
  }))
}

variable "cpu" {
  type    = number
  default = 2
}

variable "efi_boot" {
  type = bool
}

variable "namespace" {
  type        = string
  description = "Name of the namespace into which the VMs with be delployed. It must exist"
}

variable "networks" {
  type = map(object({
    ip      = optional(string, "")
    cidr    = optional(number, null)
    gateway = optional(string, "")
    dns     = optional(string, "")
    network = string
    iface   = optional(string, "")
  }))

  description = "Map of harvester VM networks to add NICs for"
}

variable "memory" {
  type    = string
  default = "16Gi"
}

variable "root_disk_size" {
  type    = string
  default = "30Gi"
}

variable "run_strategy" {
  type    = string
  default = "RerunOnFailure"
}

variable "ssh_private_key" {
  type = string
}

variable "timeout" {
  type    = string
  default = "10m"
}

variable "user_data" {
  type        = string
  description = "Data for cloud-init to use"
}

variable "vm_image" {
  type        = string
  description = "OS image to use"
}

variable "vm_image_namespace" {
  type        = string
  description = "OS image namespace to use"
}

variable "vm_tags" {
  type    = map(any)
  default = {}
}

variable "vm_username" {
  type = string
}
