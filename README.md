# terraform-harvester-k3s

A terraform module for installing k3s on harvester VMs.

## Usage

This repository provides two main Terraform modules for deploying infrastructure
on Harvester:

### Virtual Machine Module

The `virtual-machine` module allows you to create and manage virtual machines on
Harvester (primary usage is intended to be for UCL's Condenser private cloud
platform). Example usage:

```hcl
module "vm" {
  source = "github.com/UCL-MIRSG/terraform-harvester-modules//modules/virtual-machine"

  name              = "my-vm"
  namespace         = "default"
  cpu               = 2
  memory            = "16Gi"
  efi_boot         = true
  primary_interface = "eth0"
  vm_username       = "admin"

  networks = {
    eth0 = {
      ip      = "10.0.0.2"
      network = "default/net"
    }
  }

  # Optional: Configure additional disks
  additional_disks = {
    data = {
      name  = "data"
      mount = "/data"
      size  = "100Gi"
    }
  }

  ssh_private_key = file("~/.ssh/id_rsa")
  user_data       = file("cloud-init.yaml")
}
```

### K3s Cluster Module

The `k3s-cluster` module helps you deploy a high-availability K3s Kubernetes
cluster on Harvester. This module internally uses the `virtual-machine` module
to create the necessary VMs. Example usage:

```hcl
module "k3s_cluster" {
  source = "github.com/UCL-MIRSG/terraform-harvester-modules//modules/k3s-cluster"

  namespace         = "default"
  primary_interface = "eth0"
  cluster_vip      = "10.0.0.5"
  vm_username      = "admin"

  # VM configuration
  cpu           = 2
  memory        = "16Gi"
  root_disk_size = "30Gi"
  efi_boot      = true

  # K3s configuration
  k3s_version      = "v1.27.3+k3s1"
  calico_version   = "v3.26.1"
  metallb_version  = "v0.13.10"

  # Network configuration for the VMs
  networks = {
    eth0 = {
      ips      = ["10.0.0.2", "10.0.0.3", "10.0.0.4"]
      cidr    = 24
      gateway = "10.0.0.1"
      dns     = "10.0.0.1"
      network = "default/net"
    }
  }

  # Optional: Configure additional disks for the VMs
  additional_disks = {
    data = {
      name  = "data"
      mount = "/data"
      size  = "100Gi"
    }
  }
}
```

For detailed information about each module's variables and outputs, please refer
to the README files in their respective directories:

- [Virtual Machine Module Documentation](modules/virtual-machine/README.md)
- [K3s Cluster Module Documentation](modules/k3s-cluster/README.md)
