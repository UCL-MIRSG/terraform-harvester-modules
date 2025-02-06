data "harvester_image" "vm_image" {
  display_name = var.vm_image
  namespace    = var.vm_image_namespace
}

resource "harvester_virtualmachine" "vm" {
  name                 = var.name
  namespace            = var.namespace
  restart_after_update = true
  run_strategy         = var.run_strategy
  description          = "Rancher k3s ${data.harvester_image.vm_image.display_name}"
  tags = {
    ssh-user = var.vm_username
  }

  cpu    = var.cpu
  memory = var.memory

  hostname = var.name

  reserved_memory = "100Mi"
  machine_type    = "q35"

  efi = var.efi_boot

  dynamic "network_interface" {
    for_each = var.networks
    content {
      name           = network_interface.key
      network_name   = network_interface.value.network
      wait_for_lease = true
      model          = "virtio"
      type           = "bridge"
    }
  }

  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = var.root_disk_size
    bus        = "virtio"
    boot_order = 1

    image       = data.harvester_image.vm_image.id
    auto_delete = true
  }

  dynamic "disk" {
    for_each = var.additional_disks

    content {
      auto_delete = true
      bus         = "scsi"
      hot_plug    = true
      name        = disk.value.name
      size        = disk.value.size
      type        = "disk"
    }
  }

  cloudinit {
    user_data = var.user_data
    network_data = var.enable_dhcp ? "" : templatefile("${path.module}/templates/network_data.yaml.tftpl", {
      networks = var.networks
    })
  }
}

resource "null_resource" "connection_test" {
  depends_on = [harvester_virtualmachine.vm]
  connection {
    type        = "ssh"
    user        = var.vm_username
    private_key = var.ssh_private_key
    host        = harvester_virtualmachine.vm.network_interface[0].ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'connection successful!'"
    ]
  }
}
