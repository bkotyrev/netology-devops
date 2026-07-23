resource "yandex_compute_instance" "vm" {
  boot_disk {
    initialize_params {
      name       = var.vm_boot_disk_name
      type       = var.vm_boot_disk_type
      size       = var.vm_boot_disk_size
      block_size = var.vm_boot_disk_block_size
      image_id   = var.vm_image_id
    }
    auto_delete = var.vm_boot_disk_auto_delete
  }

  folder_id = var.folder_id
  hostname  = var.vm_hostname
  name      = var.vm_name

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
      vm_username       = var.vm_username
      vm_ssh_public_key = var.vm_ssh_public_key
    })

    ssh-keys                = "${var.vm_username}:${var.vm_ssh_public_key}"
    private_ui_created_from = var.vm_metadata_source
  }

  network_interface {
    subnet_id = var.subnet_id
    index     = var.vm_network_interface_index
    nat       = var.vm_nat
  }

  platform_id = var.vm_platform_id

  resources {
    memory        = var.vm_resources.memory
    cores         = var.vm_resources.cores
    core_fraction = var.vm_resources.core_fraction
  }

  scheduling_policy {
    preemptible = var.vm_preemptible
  }

  zone = var.default_zone
}
