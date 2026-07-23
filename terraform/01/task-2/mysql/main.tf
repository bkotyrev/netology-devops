resource "random_string" "mysql_name_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "random_password" "mysql_root_password" {
  length  = 16
  special = false
}

resource "random_password" "mysql_user_password" {
  length  = 16
  special = false
}

resource "docker_image" "mysql" {
  name         = var.mysql_image
  keep_locally = true
}

resource "docker_container" "mysql" {
  name  = "mysql_${random_string.mysql_name_suffix.result}"
  image = docker_image.mysql.image_id

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_password.result}",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${random_password.mysql_user_password.result}",
    "MYSQL_ROOT_HOST=${var.mysql_root_host}",
  ]

  ports {
    ip       = var.mysql_bind_ip
    internal = var.mysql_port
    external = var.mysql_port
  }
}
