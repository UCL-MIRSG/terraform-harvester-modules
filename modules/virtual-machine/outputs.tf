output "ip" {
  value = harvester_virtualmachine.vm.network_interface.0.ip_address
}
