# terraform-harvester-modules

Terraform modules for deploying virtual machines and [k3s](https://k3s.io/)
clusters on Harvester.

## virtual-machine module

The `virtual-machine` module allows you to create and manage virtual machines on
Harvester. To deploy a basic VM with a single boot disk and an IP provided by
DHCP:

```hcl
module "vm" {
  source = "github.com/UCL-ARC/terraform-harvester-modules//modules/virtual-machine"

  cpu       = 2
  efi_boot  = true
  memory    = "8Gi"
  name      = "my-vm"
  namespace = "default"
  networks = [
    {
      iface   = "nic-1"
      network = "default/net"
    }
  ]
  vm_image           = "almalinux-9.5"
  vm_image_namespace = "harvester-public"
  vm_username        = "almalinux"
}
```

To deploy a VM with a data disk in addition to the boot disk, a static IP
address and an SSH key:

```hcl
  source = "github.com/UCL-ARC/terraform-harvester-modules//modules/virtual-machine"

  additional_disks = [
    {
      boot_order = 2
      bus        = "virtio"
      name       = "data"
      mount      = "/data"
      size       = "100Gi"
      type       = "disk
    }
  ]
  cpu              = 2
  efi_boot         = true
  memory           = "8Gi"
  name             = "my-vm"
  namespace        = "default"
  networks = [
    {
      cidr    = 24
      dns     = "10.0.0.1"
      gateway = "10.0.0.1"
      iface   = "nic-1"
      ip      = "10.0.0.2"
      network = "default/net"
    }
  ]
  ssh_public_key     = file("~/.ssh/id_rsa")
  vm_image           = "almalinux-9.5"
  vm_image_namespace = "harvester-public"
  vm_username        = "almalinux"
```

It is also possible to completely customise the `cloud-config` data by providing
your own files via the `network_data` and `user_data` variables.

Note that the IP addresses and namespaces given here are illustrative only and
should be changed.

## k3s Cluster Module

The `k3s-cluster` module helps you deploy a high-availability
[k3s](https://k3s.io/) Kubernetes cluster on Harvester. This module internally
uses the `virtual-machine` module to create the necessary VMs. This module
provides `user_data` to the virtual machines, and is configured to install k3s
using the default operating system user in the machine image being used (set
using the `vm_image` variable). As such the `vm_username` variable must be set
accordingly (e.g. `cloud-user` for a RHEL machine image).

Example usage which would deploy a 3-node cluster:

```hcl
module "k3s_cluster" {
  source = "github.com/UCL-ARC/terraform-harvester-modules//modules/k3s-cluster"

  cluster_name        = "my-cluster"
  cluster_api_vip     = "10.0.0.5"
  cluster_ingress_vip = "10.0.0.6"
  namespace           = "default"
  networks = {
    eth0 = {
      ips     = ["10.0.0.2", "10.0.0.3", "10.0.0.4"]
      cidr    = 24
      gateway = "10.0.0.1"
      dns     = "10.0.0.1"
      network = "default/net"
    }
  }
  vm_image           = "rhel-9.4"
  vm_image_namespace = "default"
  vm_username        = "cloud-user"
}
```

For detailed information about each module's variables and outputs, please refer
to the README files in their respective directories:

- [Virtual Machine Module Documentation](modules/virtual-machine/README.md)
- [K3s Cluster Module Documentation](modules/k3s-cluster/README.md)
