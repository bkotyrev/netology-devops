resource "yandex_compute_disk" "storage" {
  count = 3

  name = "storage-disk-${count.index + 1}"
  type = "network-hdd"
  zone = var.default_zone
  size = 1
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"
  platform_id = "standard-v3"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 10
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage

    content {
      disk_id     = secondary_disk.value.id
      device_name = "storage-disk-${secondary_disk.key + 1}"
      auto_delete = false
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}
