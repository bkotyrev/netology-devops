packer {
  required_plugins {
    yandex = {
      version = "1.1.3"
      source  = "github.com/hashicorp/yandex"
    }
  }
}

source "yandex" "ubuntu_24_docker" {
  folder_id           = "b1gj00rnt72cp7g1jsrr"
  zone                = "ru-central1-a"
  image_name          = "ubuntu-24-docker"
  image_family        = "ubuntu-base"
  image_description   = "Ubuntu 24.04 + Docker"
  source_image_family = "ubuntu-24-04-lts"
  subnet_id           = "e9b6jt8bg9122u169c0f"
  use_ipv4_nat        = true
  disk_type           = "network-hdd"
  ssh_username        = "ubuntu"
}

build {
  name    = "ubuntu-24-docker"
  sources = ["source.yandex.ubuntu_24_docker"]

  provisioner "shell" {
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive"
    ]

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ca-certificates curl gnupg",
      "sudo install -m 0755 -d /etc/apt/keyrings",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg",
      "sudo chmod a+r /etc/apt/keyrings/docker.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
      "sudo systemctl enable docker",
      "sudo cloud-init clean --logs"
    ]
  }
}
