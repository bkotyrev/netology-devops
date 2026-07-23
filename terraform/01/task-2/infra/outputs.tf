output "vm_external_ip" {
  value = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}

output "vm_internal_ip" {
  value = yandex_compute_instance.vm.network_interface[0].ip_address
}

output "vm_fqdn" {
  value = yandex_compute_instance.vm.fqdn
}

output "ssh_command" {
  value = "ssh ${var.vm_username}@${yandex_compute_instance.vm.network_interface[0].nat_ip_address}"
}

output "docker_host" {
  value = "ssh://${var.vm_username}@${yandex_compute_instance.vm.network_interface[0].nat_ip_address}"
}
