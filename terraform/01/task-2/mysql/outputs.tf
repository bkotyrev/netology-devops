output "mysql_container_name" {
  value = docker_container.mysql.name
}

output "mysql_endpoint" {
  value = "${var.mysql_bind_ip}:${var.mysql_port}"
}

output "mysql_credentials" {
  sensitive = true

  value = {
    root_user     = "root"
    root_password = random_password.mysql_root_password.result
    database      = var.mysql_database
    user          = var.mysql_user
    password      = random_password.mysql_user_password.result
    root_host     = var.mysql_root_host
  }
}
